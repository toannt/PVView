//
//  PVActionGroup.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/14/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public final class PVActionGroup: PVActionBasic {
    public let actions: [PVActionBasic]
    public init(actions: [PVActionBasic]) {
        self.actions = actions
    }
    
    public override func step(_ progress: Double, target: UIView) {
        self.actions.forEach { $0.step(progress, target: target) }
    }
    
    public override func reverse() -> PVActionGroup {
        return PVActionGroup(actions: actions.map { $0.reverse() })
    }
}
