//
//  PVActionRotate.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public final class PVActionRotate: PVActionBasic {
    public let keyPath: String
    public let fromValue: Double
    public let toValue: Double
    
    public convenience init(fromX: Double = 0, toX: Double) {
        self.init(keyPath: "transform.rotation.x", fromValue: fromX, toValue: toX)
    }
    
    public convenience init(fromY: Double = 0, toY: Double) {
        self.init(keyPath: "transform.rotation.y", fromValue: fromY, toValue: toY)
    }
    
    public convenience init(fromZ: Double = 0, toZ: Double) {
        self.init(keyPath: "transform.rotation.z", fromValue: fromZ, toValue: toZ)
    }
    
    private init(keyPath: String, fromValue: Double, toValue: Double) {
        self.keyPath = keyPath
        self.fromValue = fromValue
        self.toValue = toValue
        super.init()
    }
    
    public override func step(_ progress: Double, target: UIView) {
        let currentRotation = fromValue + (toValue - fromValue) * progress
        target.layer.setValue(currentRotation, forKeyPath: keyPath)
    }
    
    public override func reverse() -> PVActionRotate {
        return PVActionRotate(keyPath: keyPath, fromValue: toValue, toValue: fromValue)
    }
    
    public func continueRotate(to newValue: Double) -> PVActionRotate {
        return PVActionRotate(keyPath: keyPath, fromValue: toValue, toValue: newValue)
    }
}
