//
//  PVActionOpacity.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionFade: PVActionBasicType {
    public let parameters: PVParameters
    public let fromOpacity: Double
    public let toOpacity: Double
    
    public init(from fromOpacity: Double = 1,
                to toOpacity: Double = 1,
                parameters: PVParameters = .default) {
        self.fromOpacity = fromOpacity
        self.toOpacity = toOpacity
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        let currentOpacity = fromOpacity + (toOpacity - fromOpacity) * progress
        target.layer.opacity = Float(currentOpacity)
    }

    public func reverse(with newParameters: PVParameters = .default) -> PVActionFade {
        return PVActionFade(from: toOpacity, to: fromOpacity, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionFade {
        return PVActionFade(from: fromOpacity, to: toOpacity, parameters: newParameters)
    }
    
    public func continueFade(to newOpacity: Double, newParameters: PVParameters = .default) -> PVActionFade {
        return PVActionFade(from: toOpacity, to: newOpacity, parameters: newParameters)
    }
}

