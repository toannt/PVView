//
//  PVParameters.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVParameters {
    public let startOffset: Double
    public let stopOffset: Double
    public let timingFunction: PVTimingFunctionType?
    
    public static var `default`: PVParameters {
        return PVParameters()
    }
    
    public init(startOffset: Double = 0,
                stopOffset: Double = 1,
                timingFunction: PVTimingFunctionType? = nil) {
        precondition(startOffset >= 0 && startOffset < stopOffset && stopOffset <= 1, "StartOffet must be less than EndOffset, and both must be in [0..1] range, Current: startOffset = \(startOffset), stopOffset = \(stopOffset)")
        self.startOffset = startOffset
        self.stopOffset = stopOffset
        self.timingFunction = timingFunction
    }
}
