//
//  PVActionGroup.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/14/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public class PVActionGroup: PVAction {
    public let actions: [PVAction]
    public init(actions: [PVAction]) {
        self.actions = actions
    }
    
    override public func step(_ progress: Double, target: UIView) {
        self.actions.forEach { $0.step(progress, target: target) }
    }
}
