//
//  PVViewDelegate.swift
//  PVView
//
//  Created by Toan Nguyen on 5/15/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation

public protocol PVViewDelegate: AnyObject {
    //Required
    func numberOfPages(in parallaxView: PVView) -> Int
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItemType]
    func parallaxview(_ parallaxView: PVView, viewForItem item: PVItemType) -> UIView
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItemType, onPage pageIndex: Int) -> [PVActionType]
    
    //Optional
    func direction(of parallaxView: PVView) -> PVView.PVDirection
    func parallaxView(_ parallaxView: PVView, containerViewForItem item: PVItemType, onPage pageIndex: Int) -> UIView?
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int)
    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?)
    func parallaxView(_ parallaxView: PVView, didUpdate pageProgress: Double, onPage pageIndex: Int)
}

public extension PVViewDelegate {
    func direction(of parallaxView: PVView) -> PVView.PVDirection {
        return .horizontal
    }
    func parallaxView(_ parallaxView: PVView, containerViewForItem item: PVItemType, onPage pageIndex: Int) -> UIView? {
        return nil
    }
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int) { }
    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?) { }
    func parallaxView(_ parallaxView: PVView, didUpdate pageProgress: Double, onPage pageIndex: Int) { }
}
