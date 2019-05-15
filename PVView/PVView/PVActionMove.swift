//
//  PVActionMove.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public class PVActionMove: PVAction {
    public enum MoveType {
        case position //layer.position
        case translation //layer.transform.translation
        case origin //frame.origin
    }
    
    public let fromValue: PVPoint
    public let toValue: PVPoint
    public let moveType: MoveType

    public convenience init(fromPosition: PVPoint, toPosition: PVPoint) {
        self.init(from: fromPosition, to: toPosition, type: .position)
    }
    
    public convenience init(fromTranslation: PVPoint = PVPoint.zero, toTranslation: PVPoint) {
        self.init(from: fromTranslation, to: toTranslation, type: .translation)
    }
    
    public convenience init(fromOrigin: PVPoint, toOrigin: PVPoint) {
        self.init(from: fromOrigin, to: toOrigin, type: .origin)
    }
    
    private init(from fromValue: PVPoint,
                 to toValue: PVPoint, type: MoveType) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.moveType = type
        super.init()
    }
    
    override public func step(_ progress: Double, target: UIView) {
        guard let container = target.superview else { return }
        
        let from = container.convertPoint(fromValue)
        let to = container.convertPoint(toValue)
        let current = from + (to - from) * CGFloat(progress)
        
        switch moveType {
        case .position:
            target.layer.position = current
        case .translation:
            target.layer.setValue(current, forKeyPath: "transform.translation")
        case .origin:
            target.frame.origin = current
        }
    }
    
    public func reverse() -> PVActionMove {
        return PVActionMove(from: toValue, to: fromValue, type: moveType)
    }
    
    public func continueMove(to newValue: PVPoint) -> PVActionMove {
        return PVActionMove(from: toValue, to: newValue, type: moveType)
    }
}
