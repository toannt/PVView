//
//  PVActionType.swift
//  PVView
//
//  Created by Toan Nguyen on 5/16/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

public protocol PVActionType {
    func update(_ progress: Double, target: UIView)
}
