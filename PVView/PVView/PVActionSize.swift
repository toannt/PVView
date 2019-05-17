//
//  PVActionSize.swift
//  PVView
//
//  Created by Toan Nguyen on 5/15/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionSize: PVActionBasicType {
    public let parameters: PVParameters
    public let fromSize: PVSize
    public let toSize: PVSize
    
    public init(from fromSize: PVSize, to toSize: PVSize, parameters: PVParameters = .default) {
        self.fromSize = fromSize
        self.toSize = toSize
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        guard let container = target.superview else { return }
        
        let from = container.convertSize(fromSize)
        let to = container.convertSize(toSize)
        let current = from + (to - from) * CGFloat(progress)
        let center = target.center
        target.frame = CGRect(x: center.x - current.width / 2, y: center.y - current.height / 2, width: current.width, height: current.height)
    }
    
    public func reverse(with newParameters: PVParameters = .default) -> PVActionSize {
        return PVActionSize(from: toSize, to: fromSize, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionSize {
        return PVActionSize(from: fromSize, to: toSize, parameters: newParameters)
    }
    
    public func continueChange(to newSize: PVSize, newParameters: PVParameters = .default) -> PVActionSize {
        return PVActionSize(from: toSize, to: newSize, parameters: newParameters)
    }
}
