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
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItem]
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItem, onPage pageIndex: Int) -> [PVActionType]
    
    //Optional
    func direction(of parallaxView: PVView) -> PVView.PVDirection
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int)
    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?)
}

public extension PVViewDelegate {
    func direction(of parallaxView: PVView) -> PVView.PVDirection {
        return .horizontal
    }
    
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int) { }
    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?) { }
}
