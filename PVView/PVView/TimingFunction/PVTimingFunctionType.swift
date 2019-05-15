//
//  PVTimingFunctionType.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation

public protocol PVTimingFunctionType {
    func evaluate(_ input: Double) -> Double
}
