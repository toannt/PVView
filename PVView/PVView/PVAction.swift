//
//  PVAction.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

open class PVAction {
    public var startOffset: Double = 0
    public var endOffset: Double = 1
    public var timingFunction: PVTimingFunctionType?
    
    final internal func update(_ progress: Double, target: UIView) {
        precondition(startOffset >= 0 && startOffset < endOffset && endOffset <= 1, "StartOffet must be less than EndOffset, and both must be in [0..1] range, Current: startOffset = \(startOffset), endOffset = \(endOffset)")

        let _offset = startOffset == 0 ? progress : max(progress - startOffset, 0) //Only allow bouncing at beginning of action if the action start at 0
        let _speed = 1 / (endOffset - startOffset)
        let inRangeProgress = endOffset == 1 ? _offset * _speed : min(_offset * _speed, 1) //Only allow bouncing at the end of action if the action end at 1

        let evaluatedProgress = timingFunction?.evaluate(inRangeProgress) ?? inRangeProgress
        step(evaluatedProgress, target: target)
    }

    open func step(_ progress: Double, target: UIView) {
        print("To be implemented by subclasses!")
    }
}
