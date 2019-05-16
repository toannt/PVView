//
//  PVActionFrame.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/14/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public final class PVActionFrame: PVActionBasic {
    public let fromFrame: CGRect
    public let toFrame: CGRect
    public init(fromFrame: CGRect, toFrame: CGRect) {
        self.fromFrame = fromFrame
        self.toFrame = toFrame
    }
    
    public override func step(_ progress: Double, target: UIView) {
        let origin = fromFrame.origin + (toFrame.origin - fromFrame.origin) * CGFloat(progress)
        let size = fromFrame.size + (toFrame.size - fromFrame.size) * CGFloat(progress)
        let frame = CGRect(origin: origin, size: size)
        target.frame = frame
    }
    
    public override func reverse() -> PVActionFrame {
        return PVActionFrame(fromFrame: toFrame, toFrame: fromFrame)
    }
    
    public func continueChange(to newFrame: CGRect) -> PVActionFrame {
        return PVActionFrame(fromFrame: toFrame, toFrame: newFrame)
    }
}
