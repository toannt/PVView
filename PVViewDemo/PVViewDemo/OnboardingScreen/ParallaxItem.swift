//
//  ParallaxItem.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/19/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import PVView

enum ParallaxItem: String, PVItemType {
    case iphoneBase
    case screen1
    case screen2
    case screen3
    case screen4
    case screen5
    case popup1
    case popup2
    case searchBubble
    case contactIcon
    case messageIcon
    case callingIcon
    case taskBubble
    case iMac
    case iPad
    case label1
    case label2
    case label3
    case label4
    
    var identifier: String {
        return self.rawValue
    }
}
