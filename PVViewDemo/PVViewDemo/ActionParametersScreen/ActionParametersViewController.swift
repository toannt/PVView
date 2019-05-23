//
//  ActionParametersViewController.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/22/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit
import PVView

enum TimingFunctionRow: String, CaseIterable {
    case `default`
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case easeInSine
    case easeOutSine
    case easeInOutSine
    case easeInQuad
    case easeOutQuad
    case easeInOutQuad
    case easeInCubic
    case easeOutCubic
    case easeInOutCubic
    case easeInQuart
    case easeOutQuart
    case easeInOutQuart
    case easeInQuint
    case easeOutQuint
    case easeInOutQuint
    case easeInExpo
    case easeOutExpo
    case easeInOutExpo
    case easeInCirc
    case easeOutCirc
    case easeInOutCirc
    case easeInBack
    case easeOutBack
    case easeInOutBack
    
    var function: PVTimingFunctionType {
        switch self {
        case .default:
            return PVTimingFunction(name: .default)
        case .linear:
            return PVTimingFunction(name: .linear)
        case .easeIn:
            return PVTimingFunction(name: .easeIn)
        case .easeOut:
            return PVTimingFunction(name: .easeOut)
        case .easeInOut:
            return PVTimingFunction(name: .easeInOut)
        case .easeInSine:
            return PVTimingFunction(name: .easeInSine)
        case .easeOutSine:
            return PVTimingFunction(name: .easeOutSine)
        case .easeInOutSine:
            return PVTimingFunction(name: .easeInOutSine)
        case .easeInQuad:
            return PVTimingFunction(name: .easeInQuad)
        case .easeOutQuad:
            return PVTimingFunction(name: .easeOutQuad)
        case .easeInOutQuad:
            return PVTimingFunction(name: .easeInOutQuad)
        case .easeInCubic:
            return PVTimingFunction(name: .easeInCubic)
        case .easeOutCubic:
            return PVTimingFunction(name: .easeOutCubic)
        case .easeInOutCubic:
            return PVTimingFunction(name: .easeInOutCubic)
        case .easeInQuart:
            return PVTimingFunction(name: .easeInQuart)
        case .easeOutQuart:
            return PVTimingFunction(name: .easeOutQuart)
        case .easeInOutQuart:
            return PVTimingFunction(name: .easeInOutQuart)
        case .easeInQuint:
            return PVTimingFunction(name: .easeInQuint)
        case .easeOutQuint:
            return PVTimingFunction(name: .easeOutQuint)
        case .easeInOutQuint:
            return PVTimingFunction(name: .easeInOutQuint)
        case .easeInExpo:
            return PVTimingFunction(name: .easeInExpo)
        case .easeOutExpo:
            return PVTimingFunction(name: .easeOutExpo)
        case .easeInOutExpo:
            return PVTimingFunction(name: .easeInOutExpo)
        case .easeInCirc:
            return PVTimingFunction(name: .easeInCirc)
        case .easeOutCirc:
            return PVTimingFunction(name: .easeOutCirc)
        case .easeInOutCirc:
            return PVTimingFunction(name: .easeInOutCirc)
        case .easeInBack:
            return PVTimingFunction(name: .easeInBack)
        case .easeOutBack:
            return PVTimingFunction(name: .easeOutBack)
        case .easeInOutBack:
            return PVTimingFunction(name: .easeInOutBack)
        }
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
        
}

class ActionParametersViewController: UIViewController {
    @IBOutlet weak var timingPicker: UIPickerView!
    @IBOutlet weak var startSlider: UISlider!
    @IBOutlet weak var endSlider: UISlider!
    @IBOutlet weak var startOffsetLabel: UILabel!
    @IBOutlet weak var endOffsetLabel: UILabel!
    @IBOutlet weak var parallaxView: PVView!
    let timingFunctionRows = TimingFunctionRow.allCases
    var parameters: PVParameters = .default
    
    enum Item: String, PVItemType {
        case red
        case blue
        
        var identifier: String {
            return self.rawValue
        }
        
        var view: UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            switch self {
            case .red:
                view.backgroundColor = UIColor.red
            case .blue:
                view.center = CGPoint(x: 180, y: 200)
                view.backgroundColor = UIColor.blue
            }
            return view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxView.delegate = self
        reload()
    }
    
    func reload() {
        parameters = PVParameters(startOffset: Double(startSlider.value), stopOffset: Double(endSlider.value), timingFunction: timingFunctionRows[timingPicker.selectedRow(inComponent: 0)].function)
        parallaxView.reload()
    }
    
    func updateLabels() {
        startOffsetLabel.text = NSString(format: "%.2f", startSlider.value) as String
        endOffsetLabel.text = NSString(format: "%.2f", endSlider.value) as String
    }
    
    @IBAction func startOffsetChanged(_ sender: UISlider) {
        if sender.value >= endSlider.value {
            endSlider.value = sender.value + 0.01
        }
        updateLabels()
        reload()
    }
    @IBAction func endOffsetChanged(_ sender: UISlider) {
        if sender.value <= startSlider.value {
            startSlider.value = sender.value - 0.01
        }
        updateLabels()
        reload()
    }
}

extension ActionParametersViewController: PVViewDelegate {
    func numberOfPages(in parallaxView: PVView) -> Int {
        return 2
    }
    
    func parallaxview(_ parallaxView: PVView, viewForItem item: PVItemType) -> UIView {
        return (item as! Item).view
    }
    
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItemType] {
        return [Item.red, Item.blue]
    }
    
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItemType, onPage pageIndex: Int) -> [PVActionType] {
        let item = item as! Item
        switch item {
        case .red:
            return [PVActionMove(fromOrigin: PVPoint(x: 50, y: 50), toOrigin: PVPoint(x: 250, y: 50), parameters: parameters)]
        case .blue:
            return [PVActionScale(from: 1, to: 2, parameters: parameters)]
        }
    }
}

extension ActionParametersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timingFunctionRows.count
    }
}

extension ActionParametersViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timingFunctionRows[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reload()
    }
}
