//
//  PVActionRotate.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionRotate: PVActionBasicType {
    public let parameters: PVParameters
    public let keyPath: String
    public let fromValue: Double
    public let toValue: Double
    
    public init(fromX: Double = 0, toX: Double = 0, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.rotation.x", fromValue: fromX, toValue: toX, parameters: parameters)
    }
    
    public init(fromY: Double = 0, toY: Double = 0, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.rotation.y", fromValue: fromY, toValue: toY, parameters: parameters)
    }
    
    public init(fromZ: Double = 0, toZ: Double = 0, parameters: PVParameters = .default) {
        self.init(keyPath: "transform.rotation.z", fromValue: fromZ, toValue: toZ, parameters: parameters)
    }
    
    private init(keyPath: String, fromValue: Double, toValue: Double, parameters: PVParameters) {
        self.keyPath = keyPath
        self.fromValue = fromValue
        self.toValue = toValue
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        let currentRotation = fromValue + (toValue - fromValue) * progress
        target.layer.setValue(currentRotation, forKeyPath: keyPath)
    }
    
    public func reverse(with newParameters: PVParameters = .default) -> PVActionRotate {
        return PVActionRotate(keyPath: keyPath, fromValue: toValue, toValue: fromValue, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionRotate {
        return PVActionRotate(keyPath: keyPath, fromValue: fromValue, toValue: toValue, parameters: newParameters)
    }
    
    public func continueRotate(to newValue: Double, newParameters: PVParameters = .default) -> PVActionRotate {
        return PVActionRotate(keyPath: keyPath, fromValue: toValue, toValue: newValue, parameters: newParameters)
    }
}
