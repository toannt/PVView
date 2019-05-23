//
//  PVTimingFunction.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

/// Same as CAMediaTimingFunction but provide us the "evaluate" method to calculate time
public struct PVTimingFunction {
    private static let defaultDuration = TimeInterval(1)
    public let controlPoint1: CGPoint
    public let controlPoint2: CGPoint
    
    // MARK: - Private Properties
    private var _bezier: ValueBezier
    private var _epsilon: Double
    
    // MARK: - Initialiser
    public init(controlPoint1: CGPoint, controlPoint2: CGPoint) {
        self.init(controlPoint1: controlPoint1,
                  controlPoint2: controlPoint2,
                  duration: PVTimingFunction.defaultDuration)
    }
    
    @available(iOS 10.0, *)
    public init(timingParameters: UICubicTimingParameters) {
        self.init(controlPoint1: timingParameters.controlPoint1,
                  controlPoint2: timingParameters.controlPoint2
        )
    }
    
    public init(name: PVTimingFunctionName) {
        let points = name.controlPoints()
        self.init(controlPoint1: points.p1, controlPoint2: points.p2)
    }
    
    private init(controlPoint1: CGPoint,
                 controlPoint2: CGPoint,
                 duration: TimeInterval) {
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
        _bezier = ValueBezier(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        _epsilon = PVTimingFunction.epsilon(for: duration)
    }

    static private func epsilon(for duration: TimeInterval) -> Double {
        return 1.0 / (200.0 * duration)
    }
    
    /// Transform time t to f(t)
    ///
    /// - Parameter input: Input time t
    /// - Returns: Output time t' = f(t)
    public func evaluate(_ input: Double) -> Double {
        return _bezier.value(for: input, epsilon: _epsilon)
    }
}

extension PVTimingFunction: PVTimingFunctionType {}

internal struct ValueBezier {
    private let ax: Double
    private let bx: Double
    private let cx: Double
    
    private let ay: Double
    private let by: Double
    private let cy: Double

    internal init(controlPoint1: CGPoint, controlPoint2: CGPoint) {
        cx = 3.0 * Double(controlPoint1.x)
        bx = 3.0 * Double(controlPoint2.x - controlPoint1.x) - cx
        ax = 1.0 - cx - bx
        
        cy = 3.0 * Double(controlPoint1.y)
        by = 3.0 * Double(controlPoint2.y - controlPoint1.y) - cy
        ay = 1.0 - cy - by
    }
    
    internal func value(for x: Double, epsilon: Double) -> Double {
        return sampleCurveY(solveCurveX(x, epsilon: epsilon))
    }
    
    private func sampleCurveX(_ t: Double) -> Double {
        // `ax t^3 + bx t^2 + cx t' expanded using Horner's rule.
        return ((ax * t + bx) * t + cx) * t
    }
    
    private func sampleCurveY(_ t: Double) -> Double {
        return ((ay * t + by) * t + cy) * t
    }
    
    private func sampleCurveDerivativeX(_ t: Double) -> Double {
        return (3.0 * ax * t + 2.0 * bx) * t + cx
    }
    
    private func solveCurveX(_ x: Double, epsilon: Double) -> Double {
        var t0, t1, t2, x2, d2: Double
        
        // First try a few iterations of Newton's method -- normally very fast.
        t2 = x
        for _ in (0..<8) {
            x2 = sampleCurveX(t2) - x
            guard abs(x2) >= epsilon else { return t2 }
            d2 = sampleCurveDerivativeX(t2)
            guard abs(d2) >= 1e-6 else { break }
            t2 = t2 - x2 / d2
        }
        
        // Fall back to the bisection method for reliability.
        t0 = 0.0
        t1 = 1.0
        t2 = x
        
        guard t2 >= t0 else { return t0 }
        guard t2 <= t1 else { return t1 }
        
        while t0 < t1 {
            
            x2 = sampleCurveX(t2)
            
            guard abs(x2 - x) >= epsilon else { return t2 }
            
            if x > x2 {
                t0 = t2
            } else {
                t1 = t2
            }
            
            t2 = (t1 - t0) * 0.5 + t0
        }
        
        // Failure
        
        return t2
    }
}
