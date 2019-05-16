//
//  PVActionScale.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public final class PVActionScale: PVActionBasic {
    public let keyPath: String
    public let fromValue: Double
    public let toValue: Double
    
    public convenience init(from: Double = 1, to: Double) {
        self.init(keyPath: "transform.scale", fromValue: from, toValue: to)
    }
    
    public convenience init(fromX: Double = 1, toX: Double) {
        self.init(keyPath: "transform.scale.x", fromValue: fromX, toValue: toX)
    }
    
    public convenience init(fromY: Double = 1, toY: Double) {
        self.init(keyPath: "transform.scale.y", fromValue: fromY, toValue: toY)
    }
    
    private init(keyPath: String, fromValue: Double, toValue: Double) {
        self.keyPath = keyPath
        self.fromValue = fromValue
        self.toValue = toValue
        super.init()
    }
    
    public override func step(_ progress: Double, target: UIView) {
        let scale = fromValue + (toValue - fromValue) * progress
        target.layer.setValue(scale, forKeyPath: keyPath)
    }

    public override func reverse() -> PVActionScale {
        return PVActionScale(keyPath: keyPath, fromValue: toValue, toValue: fromValue)
    }
    
    public func continueScale(to newValue: Double) -> PVActionScale {
        return PVActionScale(keyPath: keyPath, fromValue: toValue, toValue: fromValue)
    }
}
