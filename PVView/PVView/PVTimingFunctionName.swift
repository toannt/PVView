//
//  PVTimingFunctionName.swift
//  PVView
//
//  Created by Toan Nguyen on 5/23/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation

/// Ref: https://easings.net/en
public enum PVTimingFunctionName {
    case `default`
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case easeInSine
    case easeOutSine
    case easeInOutSine
    case easeInQuad
    case easeOutQuad
    case easeInOutQuad
    case easeInCubic
    case easeOutCubic
    case easeInOutCubic
    case easeInQuart
    case easeOutQuart
    case easeInOutQuart
    case easeInQuint
    case easeOutQuint
    case easeInOutQuint
    case easeInExpo
    case easeOutExpo
    case easeInOutExpo
    case easeInCirc
    case easeOutCirc
    case easeInOutCirc
    case easeInBack
    case easeOutBack
    case easeInOutBack
    
    internal func controlPoints() -> (p1: CGPoint, p2: CGPoint) {
        switch self {
        case .default:
            return (CGPoint(x: 0.25, y: 0.1), CGPoint(x: 0.25, y: 1))
        case .linear:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
        case .easeIn:
            return (CGPoint(x: 0.42, y: 0), CGPoint(x: 1, y: 1))
        case .easeOut:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0.58, y: 1))
        case .easeInOut:
            return (CGPoint(x: 0.42, y: 0), CGPoint(x: 0.58, y: 1))
        case .easeInSine:
            return (CGPoint(x: 0.47, y: 0), CGPoint(x: 0.745, y: 0.715))
        case .easeOutSine:
            return (CGPoint(x: 0.39, y: 0.575), CGPoint(x: 0.565, y: 1))
        case .easeInOutSine:
            return (CGPoint(x: 0.445, y: 0.05), CGPoint(x: 0.55, y: 0.95))
        case .easeInQuad:
            return (CGPoint(x: 0.55, y: 0.085), CGPoint(x: 0.68, y: 0.53))
        case .easeOutQuad:
            return (CGPoint(x: 0.25, y: 0.46), CGPoint(x: 0.45, y: 0.94))
        case .easeInOutQuad:
            return (CGPoint(x: 0.455, y: 0.03), CGPoint(x: 0.515, y: 0.955))
        case .easeInCubic:
            return (CGPoint(x: 0.55, y: 0.055), CGPoint(x: 0.675, y: 0.19))
        case .easeOutCubic:
            return (CGPoint(x: 0.215, y: 0.61), CGPoint(x: 0.355, y: 1))
        case .easeInOutCubic:
            return (CGPoint(x: 0.645, y: 0.045), CGPoint(x: 0.355, y: 1))
        case .easeInQuart:
            return (CGPoint(x: 0.895, y: 0.03), CGPoint(x: 0.685, y: 0.22))
        case .easeOutQuart:
            return (CGPoint(x: 0.165, y: 0.84), CGPoint(x: 0.44, y: 1))
        case .easeInOutQuart:
            return (CGPoint(x: 0.77, y: 0), CGPoint(x: 0.175, y: 1))
        case .easeInQuint:
            return (CGPoint(x: 0.755, y: 0.05), CGPoint(x: 0.855, y: 0.06))
        case .easeOutQuint:
            return (CGPoint(x: 0.23, y: 1), CGPoint(x: 0.32, y: 1))
        case .easeInOutQuint:
            return (CGPoint(x: 0.86, y: 0), CGPoint(x: 0.07, y: 1))
        case .easeInExpo:
            return (CGPoint(x: 0.95, y: 0.05), CGPoint(x: 0.795, y: 0.035))
        case .easeOutExpo:
            return (CGPoint(x: 0.19, y: 1), CGPoint(x: 0.22, y: 1))
        case .easeInOutExpo:
            return (CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1))
        case .easeInCirc:
            return (CGPoint(x: 0.6, y: 0.04), CGPoint(x: 0.98, y: 0.335))
        case .easeOutCirc:
            return (CGPoint(x: 0.075, y: 0.82), CGPoint(x: 0.165, y: 1))
        case .easeInOutCirc:
            return (CGPoint(x: 0.785, y: 0.135), CGPoint(x: 0.15, y: 0.86))
        case .easeInBack:
            return (CGPoint(x: 0.6, y: -0.28), CGPoint(x: 0.735, y: 0.045))
        case .easeOutBack:
            return (CGPoint(x: 0.175, y: 0.885), CGPoint(x: 0.32, y: 1.275))
        case .easeInOutBack:
            return (CGPoint(x: 0.68, y: -0.55), CGPoint(x: 0.265, y: 1.55))
        }
    }
}
