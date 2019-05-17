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
    public var isPagingEnabled = true {
        didSet {
            _scrollView.isPagingEnabled = isPagingEnabled
        }
    }
    
    private typealias PVElement = (item: PVItem, actions: [PVActionType])
    private let _scrollView = UIScrollView(frame: CGRect.zero)
    private var elements = [PVElement]()
    private var allTargets = Set<UIView>()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setups()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setups()
    }
    
    private func setups() {
        addSubview(_scrollView)
        _scrollView.isPagingEnabled = true
        _scrollView.delegate = self
        _scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([_scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     _scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                                     _scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     _scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    public func itemOnCurrentPage(by identifier: String) -> PVItem? {
        return elements.first(where: { $0.item.identifier == identifier})?.item
    }
    
    public func actionsOnCurrentPage(forItemBy identifier: String) -> [PVActionType] {
        return elements.first(where: { $0.item.identifier == identifier })?.actions ?? []
    }
    
    public func reload() {
        cleanUp()
        direction = delegate.direction(of: self)
        numberOfPages = delegate.numberOfPages(in: self)
        precondition(numberOfPages >= 0, "Number of pages in PVView must be positive (current: \(numberOfPages))")
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        switch direction {
        case .horizontal:
            _scrollView.contentSize = CGSize(width: CGFloat(numberOfPages + 1) * _scrollView.frame.width, height: _scrollView.frame.height)
        case .vertical:
            _scrollView.contentSize = CGSize(width: _scrollView.frame.width, height: CGFloat(numberOfPages + 1) * _scrollView.frame.height)
        }
        
        update(scrollOffset())
    }
    
    private func cleanUp() {
        currentPageIndex = nil
        elements = []
        _scrollView.contentOffset = CGPoint.zero
        for view in allTargets {
            view.removeFromSuperview()
        }
        allTargets = []
    }
    
    private func willBeginTransition(to pageIndex: Int) {
        if let currentIndex = self.currentPageIndex {
            updateActions( pageIndex > currentIndex ? 1 : 0)
        }
        
        delegate.parallaxView(self, willBeginTransitionTo: pageIndex)
    }
    
    private func startTransition(to pageIndex: Int) {
        let items = delegate.parallaxView(self, itemsOnPage: pageIndex)
        elements = items.map { ($0, delegate.parallaxView(self, actionsOfItem: $0, onPage: pageIndex)) }
        currentPageIndex = pageIndex
        
        for item in items {
            let containerView = item.container ?? self
            if item.target.superview !== containerView {
                containerView.addSubview(item.target)
            }
            allTargets.insert(item.target)
        }
    }
    
    private func didEndTransition(from previousPageIndex: Int?) {
        elements.forEach { $0.item.target.superview?.bringSubviewToFront($0.item.target) }
        delegate.parallaxView(self, didEndTransitionFrom: previousPageIndex)
    }

    private func updateActions(_ progress: Double) {
        for anElement in self.elements {
            anElement.actions.forEach { $0.update(progress, target: anElement.item.target) }
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
        
        let pageOffset = offset - pageSize * CGFloat(pageIndex)
        let pageProgress = Double(pageOffset / pageSize)
        updateActions(pageProgress)
    }
    
    private func scrollOffset() -> CGFloat {
        return direction == .horizontal ? _scrollView.contentOffset.x : _scrollView.contentOffset.y
    }
    
    private func pageSize() -> CGFloat {
        return direction == .horizontal ? _scrollView.frame.width : _scrollView.frame.height
    }
}

extension PVView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        update(scrollOffset())
    }
}
