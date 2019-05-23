//
//  OptionsViewController.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/22/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit
import PVView

extension String: PVItemType {
    public var identifier: String {
        return self
    }
}

class OptionsViewController: UIViewController {
    @IBOutlet weak var parallaxView: PVView!
    @IBOutlet weak var runActionsAfterTransitionSwitch: UISwitch!
    @IBOutlet weak var ignoreLastPageSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxView.delegate = self
        parallaxView.reload()
    }
    @IBAction func runActionSwitchChanged(_ sender: UISwitch) {
        parallaxView.runActionsAfterTransition = sender.isOn
        parallaxView.reload()
    }
    @IBAction func ignoreLastPageSwitchChanged(_ sender: UISwitch) {
        parallaxView.ignoreLastPage = sender.isOn
        parallaxView.reload()
    }
}

extension OptionsViewController: PVViewDelegate {
    func numberOfPages(in parallaxView: PVView) -> Int {
        return 2
    }
    
    func parallaxview(_ parallaxView: PVView, viewForItem item: PVItemType) -> UIView {
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 40, height: 40))
        view.backgroundColor = UIColor.red
        return view
    }
    
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItemType] {
        return ["item"]
    }
    
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItemType, onPage pageIndex: Int) -> [PVActionType] {
        print("Request actions on page: \(pageIndex)")
        if pageIndex == 0 {
            return [PVActionMove(fromOrigin: PVPoint(x: 50, y: 200), toOrigin: PVPoint(x: 250, y: 200))]
        }
        
        return []
    }
}
