//
//  PVActionType.swift
//  PVView
//
//  Created by Toan Nguyen on 5/16/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public protocol PVActionType {
    func update(_ progress: Double, target: UIView)
}

public protocol PVActionBasicType: PVActionType {
    var parameters: PVParameters { get }
    func step(_ progress: Double, target: UIView)
    func reverse(with newParameters: PVParameters) -> Self
}

public extension PVActionBasicType {
    func update(_ progress: Double, target: UIView) {
        let _offset = parameters.startOffset == 0 ? progress : max(progress - parameters.startOffset, 0) //Only allow bouncing at beginning of action if the action start at 0
        let _speed = 1 / (parameters.stopOffset - parameters.startOffset)
        let inRangeProgress = parameters.stopOffset == 1 ? _offset * _speed : min(_offset * _speed, 1) //Only allow bouncing at the end of action if the action end at 1
        
        let evaluatedProgress = parameters.timingFunction?.evaluate(inRangeProgress) ?? inRangeProgress
        step(evaluatedProgress, target: target)
    }
}
