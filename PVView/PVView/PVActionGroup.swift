//
//  PVActionGroup.swift
//  PVView
//
//  Created by Toan Nguyen on 5/14/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public struct PVActionGroup: PVActionBasicType {
    public let parameters: PVParameters
    public let actions: [PVActionBasicType]
    
    public init(actions: [PVActionBasicType], parameters: PVParameters = .default) {
        self.actions = actions
        self.parameters = parameters
    }
    
    public func step(_ progress: Double, target: UIView) {
        self.actions.forEach { $0.step(progress, target: target) }
    }
    
    public func reverse(with newParameters: PVParameters = .default) -> PVActionGroup {
        return PVActionGroup(actions: actions.reverseAll(), parameters: newParameters)
    }
    
    public func copy(with newParameters: PVParameters = .default) -> PVActionGroup {
        return PVActionGroup(actions: actions, parameters: newParameters)
    }
}
