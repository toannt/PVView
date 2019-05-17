//
//  PVActionMove.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionMove: PVActionBasicType {
    public enum MoveType {
        case position //layer.position
        case translation //layer.transform.translation
        case origin //frame.origin
    }
    public let parameters: PVParameters
    public let fromValue: PVPoint
    public let toValue: PVPoint
    public let moveType: MoveType

    public init(fromPosition: PVPoint, toPosition: PVPoint, parameters: PVParameters = .default) {
        self.init(from: fromPosition, to: toPosition, type: .position, parameters: parameters)
    }
    
    public init(fromTranslation: PVPoint = .zero, toTranslation: PVPoint = .zero, parameters: PVParameters = .default) {
        self.init(from: fromTranslation, to: toTranslation, type: .translation, parameters: parameters)
    }
    
    public init(fromOrigin: PVPoint, toOrigin: PVPoint, parameters: PVParameters = .default) {
        self.init(from: fromOrigin, to: toOrigin, type: .origin, parameters: parameters)
    }
    
    private init(from fromValue: PVPoint,
                 to toValue: PVPoint,
                 type: MoveType,
                 parameters: PVParameters) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.moveType = type
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
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
    
    public func reverse(with newParameters: PVParameters = .default) -> PVActionMove {
        return PVActionMove(from: toValue, to: fromValue, type: moveType, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionMove {
        return PVActionMove(from: fromValue, to: toValue, type: moveType, parameters: newParameters)
    }
    
    public func continueMove(to newValue: PVPoint, newParameters: PVParameters = .default) -> PVActionMove {
        return PVActionMove(from: toValue, to: newValue, type: moveType, parameters: newParameters)
    }
}
