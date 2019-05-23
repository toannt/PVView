//
//  LetterSpacingAction.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/21/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import PVView

struct LetterSpacingAction: PVActionBasicType {
    let parameters: PVParameters
    let fromSpacing: Double
    let toSpacing: Double
    let maxWidth: CGFloat
    init(fromSpacing: Double, toSpacing: Double, maxWidth: CGFloat, parameters: PVParameters = .default) {
        self.fromSpacing = fromSpacing
        self.toSpacing = toSpacing
        self.maxWidth = maxWidth
        self.parameters = parameters
    }
    
    func step(_ progress: Double, target: UIView) {
        guard let label = target as? UILabel else { return }
        let current = fromSpacing + (toSpacing - fromSpacing) * progress
        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: [.kern : current])
        label.frame = CGRect(origin: label.frame.origin, size: label.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)))
    }
    
    func reverse(with newParameters: PVParameters) -> LetterSpacingAction {
        return LetterSpacingAction(fromSpacing: toSpacing,
                                   toSpacing: fromSpacing,
                                   maxWidth: maxWidth,
                                   parameters: newParameters)
    }
    
    
}
