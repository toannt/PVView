//
//  StrokePathAction.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/21/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import PVView

protocol ShapeLayerContainerType {
    var shapeLayer: CAShapeLayer { get }
}

struct StrokePathAction: PVActionBasicType {
    let parameters: PVParameters
    let fromValue: Double
    let toValue: Double
    init(fromValue: Double, toValue: Double, parameters: PVParameters = .default) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.parameters = parameters
    }
    
    func step(_ progress: Double, target: UIView) {
        guard let layer = (target as? ShapeLayerContainerType)?.shapeLayer else { return }
        let current = fromValue + (toValue - fromValue) * progress
        layer.strokeEnd = CGFloat(current)
    }
    
    func reverse(with newParameters: PVParameters) -> StrokePathAction {
        return StrokePathAction(fromValue: toValue, toValue: fromValue, parameters: newParameters)
    }
    
    
}
