//
//  CustomActionViewController.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/21/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit
import PVView

class CustomActionViewController: UIViewController {
    enum Item: String, PVItemType {
        case label
        case shape
        var identifier: String {
            return self.rawValue
        }
        
        var view: UIView {
            switch self {
            case .label:
                let label = UILabel(frame: CGRect(x: 16, y: 100, width: UIScreen.main.bounds.width - 32, height: 100))
                label.numberOfLines = 0
                label.text = "Custom letter spacing"
                label.font = UIFont.systemFont(ofSize: 20)
                return label
            case .shape:
                let view = ShapeView(frame: CGRect(x: 20, y: 300, width: 240, height: 120))
                view.setPath(path())
                return view
            }
        }
        
        private func path() -> UIBezierPath {
            let bezierPath = UIBezierPath()
            bezierPath.move(to: CGPoint(x: 18.5, y: 52.95))
            bezierPath.addCurve(to: CGPoint(x: 53.5, y: 13.87), controlPoint1: CGPoint(x: 18.5, y: 53.88), controlPoint2: CGPoint(x: 56.5, y: 22.24))
            bezierPath.addCurve(to: CGPoint(x: 31.5, y: 8.28), controlPoint1: CGPoint(x: 50.5, y: 5.49), controlPoint2: CGPoint(x: 34.5, y: 2.7))
            bezierPath.addCurve(to: CGPoint(x: 31.5, y: 111.57), controlPoint1: CGPoint(x: 28.5, y: 13.87), controlPoint2: CGPoint(x: 31.5, y: 111.57))
            bezierPath.addCurve(to: CGPoint(x: 48.5, y: 55.74), controlPoint1: CGPoint(x: 31.5, y: 111.57), controlPoint2: CGPoint(x: 27.5, y: 55.74))
            bezierPath.addCurve(to: CGPoint(x: 67.5, y: 111.57), controlPoint1: CGPoint(x: 69.5, y: 55.74), controlPoint2: CGPoint(x: 58.5, y: 111.57))
            bezierPath.addCurve(to: CGPoint(x: 99.5, y: 70.63), controlPoint1: CGPoint(x: 76.5, y: 111.57), controlPoint2: CGPoint(x: 101.5, y: 80.86))
            bezierPath.addCurve(to: CGPoint(x: 82.5, y: 61.32), controlPoint1: CGPoint(x: 97.5, y: 60.39), controlPoint2: CGPoint(x: 89.5, y: 58.53))
            bezierPath.addCurve(to: CGPoint(x: 76.5, y: 86.45), controlPoint1: CGPoint(x: 75.5, y: 64.11), controlPoint2: CGPoint(x: 76.5, y: 82.72))
            bezierPath.addCurve(to: CGPoint(x: 102.5, y: 111.57), controlPoint1: CGPoint(x: 76.5, y: 90.17), controlPoint2: CGPoint(x: 74.5, y: 124.6))
            bezierPath.addCurve(to: CGPoint(x: 131.5, y: 5.49), controlPoint1: CGPoint(x: 130.5, y: 98.54), controlPoint2: CGPoint(x: 143.5, y: 5.49))
            bezierPath.addCurve(to: CGPoint(x: 142.5, y: 111.57), controlPoint1: CGPoint(x: 119.5, y: 5.49), controlPoint2: CGPoint(x: 114.5, y: 114.36))
            bezierPath.addCurve(to: CGPoint(x: 165.5, y: 5.49), controlPoint1: CGPoint(x: 170.5, y: 108.78), controlPoint2: CGPoint(x: 175.5, y: 9.21))
            bezierPath.addCurve(to: CGPoint(x: 167.5, y: 111.5), controlPoint1: CGPoint(x: 155.5, y: 1.77), controlPoint2: CGPoint(x: 154.5, y: 111.5))
            bezierPath.addCurve(to: CGPoint(x: 213.5, y: 101.34), controlPoint1: CGPoint(x: 180.5, y: 111.5), controlPoint2: CGPoint(x: 205.5, y: 114.36))
            bezierPath.addCurve(to: CGPoint(x: 195.5, y: 73.5), controlPoint1: CGPoint(x: 221.5, y: 88.31), controlPoint2: CGPoint(x: 212.5, y: 70.71))
            bezierPath.addCurve(to: CGPoint(x: 177.5, y: 95.75), controlPoint1: CGPoint(x: 178.5, y: 76.29), controlPoint2: CGPoint(x: 174.5, y: 84.59))
            bezierPath.addCurve(to: CGPoint(x: 193.5, y: 110.64), controlPoint1: CGPoint(x: 180.5, y: 106.92), controlPoint2: CGPoint(x: 193.5, y: 110.64))
            return bezierPath
        }
    }
    @IBOutlet weak var parallaxView: PVView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxView.delegate = self
        parallaxView.ignoreLastPage = true
        parallaxView.reload()
    }
}

extension CustomActionViewController: PVViewDelegate {
    func numberOfPages(in parallaxView: PVView) -> Int {
        return 2
    }
    
    func parallaxview(_ parallaxView: PVView, viewForItem item: PVItemType) -> UIView {
        return (item as! Item).view
    }
    
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItemType] {
        return [Item.label, Item.shape]
    }
    
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItemType, onPage pageIndex: Int) -> [PVActionType] {
        let item = item as! Item
        switch item {
        case .label:
            return [LetterSpacingAction(fromSpacing: 2, toSpacing: 20, maxWidth: self.view.bounds.width - 32)]
        case .shape:
            return [StrokePathAction(fromValue: 0, toValue: 1)]
        }
    }
}
