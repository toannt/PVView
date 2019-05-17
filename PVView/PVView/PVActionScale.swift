//
//  PVActionScale.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionScale: PVActionBasicType {
    public let parameters: PVParameters
    public let keyPath: String
    public let fromValue: Double
    public let toValue: Double
    
    public init(from: Double = 1, to: Double = 1, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.scale", fromValue: from, toValue: to, parameters: parameters)
    }
    
    public init(fromX: Double = 1, toX: Double = 1, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.scale.x", fromValue: fromX, toValue: toX, parameters: parameters)
    }
    
    public init(fromY: Double = 1, toY: Double = 1, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.scale.y", fromValue: fromY, toValue: toY, parameters: parameters)
    }
    
    private init(keyPath: String, fromValue: Double, toValue: Double, parameters: PVParameters) {
        self.keyPath = keyPath
        self.fromValue = fromValue
        self.toValue = toValue
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        let scale = fromValue + (toValue - fromValue) * progress
        target.layer.setValue(scale, forKeyPath: keyPath)
    }

    public func reverse(with newParameters: PVParameters = .default) -> PVActionScale {
        return PVActionScale(keyPath: keyPath, fromValue: toValue, toValue: fromValue, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionScale {
        return PVActionScale(keyPath: keyPath, fromValue: fromValue, toValue: toValue, parameters: newParameters)
    }
    
    public func continueScale(to newValue: Double, newParameters: PVParameters = .default) -> PVActionScale {
        return PVActionScale(keyPath: keyPath, fromValue: toValue, toValue: newValue, parameters: newParameters)
    }
}
