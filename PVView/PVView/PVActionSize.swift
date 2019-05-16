//
//  PVActionSize.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/15/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public final class PVActionSize: PVActionBasic {
    public let fromSize: PVSize
    public let toSize: PVSize
    
    public init(from fromSize: PVSize, to toSize: PVSize) {
        self.fromSize = fromSize
        self.toSize = toSize
        super.init()
    }
    
    public override func step(_ progress: Double, target: UIView) {
        guard let container = target.superview else { return }
        
        let from = container.convertSize(fromSize)
        let to = container.convertSize(toSize)
        let current = from + (to - from) * CGFloat(progress)
        let center = target.center
        target.frame = CGRect(x: center.x - current.width / 2, y: center.y - current.height / 2, width: current.width, height: current.height)
    }
    
    public override func reverse() -> PVActionSize {
        return PVActionSize(from: toSize, to: fromSize)
    }
    
    public func continueChange(to newSize: PVSize) -> PVActionSize {
        return PVActionSize(from: toSize, to: newSize)
    }
}
