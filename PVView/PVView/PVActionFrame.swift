//
//  PVActionFrame.swift
//  PVView
//
//  Created by Toan Nguyen on 5/14/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionFrame: PVActionBasicType {
    public let parameters: PVParameters
    public let fromFrame: CGRect
    public let toFrame: CGRect
    
    public init(fromFrame: CGRect, toFrame: CGRect, parameters: PVParameters = .default) {
        self.fromFrame = fromFrame
        self.toFrame = toFrame
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        let origin = fromFrame.origin + (toFrame.origin - fromFrame.origin) * CGFloat(progress)
        let size = fromFrame.size + (toFrame.size - fromFrame.size) * CGFloat(progress)
        let frame = CGRect(origin: origin, size: size)
        target.frame = frame
    }

    public func reverse(with newParameters: PVParameters = .default) -> PVActionFrame {
        return PVActionFrame(fromFrame: toFrame, toFrame: fromFrame, parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionFrame {
        return PVActionFrame(fromFrame: fromFrame, toFrame: toFrame, parameters: newParameters)
    }
    
    public func continueChange(to newFrame: CGRect, newParameters: PVParameters = .default) -> PVActionFrame {
        return PVActionFrame(fromFrame: toFrame, toFrame: newFrame, parameters: newParameters)
    }
}
