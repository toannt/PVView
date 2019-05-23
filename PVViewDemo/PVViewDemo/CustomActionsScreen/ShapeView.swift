//
//  ShapeView.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/21/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

class ShapeView: UIView, ShapeLayerContainerType {
    let shapeLayer: CAShapeLayer
    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        shapeLayer.actions = ["strokeEnd": NSNull()]
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        self.isUserInteractionEnabled = false
        self.layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        shapeLayer.frame = self.bounds
        super.layoutSubviews()
    }
    
    func setPath(_ path: UIBezierPath) {
        shapeLayer.path = path.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
