//
//  Helper.swift
//  PVView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVPoint {
    public var x: Double
    public var y: Double
    public var isRelative: Bool
    
    public static var zero: PVPoint {
        return PVPoint(x: 0, y: 0)
    }
    
    public init(x: Double, y: Double, isRelative: Bool = false) {
        self.x = x
        self.y = y
        self.isRelative = isRelative
    }
    
    public func asCGPoint() -> CGPoint {
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
}

public struct PVSize {
    public var width: Double
    public var height: Double
    public var isRelative: Bool
    
    public static var zero: PVSize {
        return PVSize(width: 0, height: 0)
    }
    
    public init(width: Double, height: Double, isRelative: Bool = false) {
        self.width = width
        self.height = height
        self.isRelative = isRelative
    }
    
    public func asCGSize() -> CGSize {
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}

public extension UIView {
    func convertPoint(_ point: PVPoint) -> CGPoint {
        let p = point.asCGPoint()
        let size = self.bounds.size
        return point.isRelative ? CGPoint(x: p.x * size.width, y: p.y * size.height) : p
    }
    
    func convertSize(_ size: PVSize) -> CGSize {
        let s = size.asCGSize()
        let containerSize = self.bounds.size
        return size.isRelative ? CGSize(width: s.width * containerSize.width, height: s.height * containerSize.height) : s
    }
}

public extension Sequence where Element == PVActionBasicType {
    func reversedActions(with newParameters: PVParameters = .default) -> [Element] {
        return self.map { $0.reverse(with: newParameters) }
    }
}

public extension Sequence where Element: PVActionBasicType {
    func reversedActions(with newParameters: PVParameters = .default) -> [Element] {
        return self.map { $0.reverse(with: newParameters) }
    }
}

//MARK:- Math
public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}
