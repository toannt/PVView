//
//  PVView.swift
//  PVView
//
//  Created by Toan Nguyen on 5/2/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

private struct PVElement {
    let identifier: String
    let target: UIView
    let container: UIView
    let actions: [PVActionType]
}

open class PVView: UIView {
    public enum PVDirection {
        case horizontal
        case vertical
    }
    
    public unowned var delegate: PVViewDelegate!
    public private(set) var direction = PVDirection.horizontal
    public private(set) var numberOfPages = 0
    public private(set) var currentPageIndex: Int?
    public var runActionsAfterTransition = true
    public var ignoreLastPage = true
    public private(set) lazy var scrollView = UIScrollView(frame: self.bounds)
    
    private var elements = [PVElement]()
    private var allTargets = [String: UIView]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setups()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setups()
    }
    
    private func setups() {
        addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
    }
    
    public func viewForItem(by identifier: String) -> UIView? {
        return allTargets[identifier]
    }
    
    public func actionsOnCurrentPage(forItemBy identifier: String) -> [PVActionType] {
        return elements.first(where: { $0.identifier == identifier })?.actions ?? []
    }
    
    public func next(animated: Bool = true) {
        guard let currentPage = self.currentPageIndex, currentPage < numberOfPages - 1 else { return }
        scroll(to: CGFloat(currentPage + 1) * pageSize(), animated: animated)
    }
    
    public func back(animated: Bool = true) {
        guard let currentPage = self.currentPageIndex, currentPage > 0 else { return }
        scroll(to: CGFloat(currentPage - 1) * pageSize(), animated: animated)
    }
    
    public func reload() {
        cleanUp()
        direction = delegate.direction(of: self)
        numberOfPages = delegate.numberOfPages(in: self)
        precondition(numberOfPages >= 0, "Number of pages in PVView must be positive (current: \(numberOfPages))")
        updateScrollContentSize()
        
        if scrollView.contentOffset == CGPoint.zero {
            update(0)
        } else {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    private func cleanUp() {
        currentPageIndex = nil
        elements = []
        for (_, view) in allTargets {
            view.removeFromSuperview()
        }
        allTargets = [:]
    }
    
    open override func layoutSubviews() {
        if scrollView.frame != self.bounds {
            scrollView.frame = self.bounds
            updateScrollContentSize()
        }
        super.layoutSubviews()
    }
    
    private func isPageIgnored(_ pageIndex: Int) -> Bool {
        return ignoreLastPage && pageIndex == numberOfPages - 1
    }
    
    private func updateScrollContentSize() {
        switch direction {
        case .horizontal:
            scrollView.contentSize = CGSize(width: CGFloat(numberOfPages) * scrollView.frame.width, height: scrollView.frame.height)
        case .vertical:
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: CGFloat(numberOfPages) * scrollView.frame.height)
        }
    }
    
    private func willBeginTransition(to pageIndex: Int) {
        if let currentIndex = self.currentPageIndex, !isPageIgnored(currentIndex) {
            updateActions( pageIndex > currentIndex ? 1 : 0)
        }
        
        delegate.parallaxView(self, willBeginTransitionTo: pageIndex)
    }
    
    private func startTransition(to pageIndex: Int) {
        defer {
            currentPageIndex = pageIndex
        }
        
        if isPageIgnored(pageIndex) {
            return
        }
        
        let items = delegate.parallaxView(self, itemsOnPage: pageIndex)
        elements = items.map { anItem in
            let identifier = anItem.identifier
            var target = allTargets[identifier]
            if target == nil {
                target = delegate.parallaxview(self, viewForItem: anItem)
                allTargets[identifier] = target!
            }
            let container = delegate.parallaxView(self, containerViewForItem: anItem, onPage: pageIndex) ?? self
            container.addSubview(target!)
            let actions = delegate.parallaxView(self, actionsOfItem: anItem, onPage: pageIndex)
            
            return PVElement(identifier: identifier,
                             target: target!,
                             container: container,
                             actions: actions)
        }
    }
    
    private func didEndTransition(from previousPageIndex: Int?) {
        delegate.parallaxView(self, didEndTransitionFrom: previousPageIndex)
    }

    private func updateActions(_ progress: Double) {
        for anElement in self.elements {
            anElement.actions.forEach { $0.update(progress, target: anElement.target) }
        }
    }
    
    private func update(_ offset: CGFloat) {
        let pageSize = self.pageSize()
        if numberOfPages < 1 || pageSize == 0 {
            return
        }
        let pageIndex = max(min(Int(abs(offset / pageSize)), numberOfPages - 1), 0)
        let currentPageIndex = self.currentPageIndex
        if pageIndex != currentPageIndex {
            willBeginTransition(to: pageIndex)
            startTransition(to: pageIndex)
            didEndTransition(from: currentPageIndex)
            if !runActionsAfterTransition {
                return
            }
        }
        
        let interactivePageIndex = isPageIgnored(pageIndex) ? max(pageIndex - 1, 0) : pageIndex
        let pageOffset = offset - pageSize * CGFloat(interactivePageIndex)
        let pageProgress = Double(pageOffset / pageSize)
        updateActions(pageProgress)
    }
    
    private func scrollOffset() -> CGFloat {
        return direction == .horizontal ? scrollView.contentOffset.x : scrollView.contentOffset.y
    }
    
    private func pageSize() -> CGFloat {
        return direction == .horizontal ? scrollView.bounds.width : scrollView.bounds.height
    }
    
    private func scroll(to newOffset: CGFloat, animated: Bool) {
        let contentOffset = direction == .horizontal ? CGPoint(x: newOffset, y: 0) : CGPoint(x: 0, y: newOffset)
        scrollView.setContentOffset(contentOffset, animated: animated)
    }
}

extension PVView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        update(scrollOffset())
    }
}
