//
//  ViewController.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/21/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import Foundation
import UIKit

enum Row {
    case onboarding
    case customActions
    case actionParameters
    case optionsOnPVView
    
    var title: String {
        switch self {
        case .onboarding:
            return "Onboarding"
        case .customActions:
            return "Custom actions"
        case .actionParameters:
            return "Action parameters"
        case .optionsOnPVView:
            return "PVView's options"
        }
    }
    
    var storyboardIdentifier: String {
        switch self {
        case .onboarding:
            return "OnboardingViewController"
        case .customActions:
            return "CustomActionViewController"
        case .actionParameters:
            return "ActionParametersViewController"
        case .optionsOnPVView:
            return "OptionsViewController"
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let rows = [Row.onboarding, .customActions, .actionParameters, .optionsOnPVView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func showOnboarding(_ sender: Any) {
        let onboardingVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController")
        self.present(onboardingVc, animated: true)
    }
    @IBAction func showCustomActions(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomActionViewController")
        self.present(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: rows[indexPath.row].storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

