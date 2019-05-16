//
//  PVItem.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/10/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

open class PVItem {
    public let identifier: String
    public let target: UIView
    public weak var container: UIView?
    
    public init(identifier: String,
              target: UIView,
              container: UIView? = nil) {
        self.identifier = identifier
        self.target = target
        self.container = container
    }
}

extension PVItem: Equatable {
    public static func == (lhs: PVItem, rhs: PVItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
