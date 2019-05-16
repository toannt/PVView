//
//  ViewController.swift
//  ParallaxView
//
//  Created by Toan Nguyen on 5/2/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import UIKit
import PVView

class ViewController: UIViewController {
    struct Identifier {
        static let iphoneBase = "iphoneBase"
        static let screen1 = "screen1"
        static let screen2 = "screen2"
        static let screen3 = "screen3"
        static let screen4 = "screen4"
        static let screen5 = "screen5"
        static let popup1 = "popup1"
        static let popup2 = "popup2"
        static let searchBubble = "searchBubble"
        static let contactIcon = "contactIcon"
        static let messageIcon = "messageIcon"
        static let callingIcon = "callingIcon"
        static let taskBubble = "taskBubble"
        static let iMac = "imac"
        static let iPad = "ipad"
    }
    typealias Element = (item: PVItem, actions: [PVAction])
    var pages: [[Element]]!
    lazy var parallaxView: PVView = {
        let view = PVView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    let iphoneView: UIView = {
        let iphoneImage = #imageLiteral(resourceName: "iphone_base")
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: iphoneImage.size))
        let iphoneBgrView = UIImageView(image: iphoneImage)
        iphoneBgrView.frame = view.bounds
        view.addSubview(iphoneBgrView)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var iphoneScreenView: UIView = {
        let view = UIView(frame: self.iphoneView.bounds.insetBy(dx: 10, dy: 37))
        view.layer.masksToBounds = true
        self.iphoneView.addSubview(view)
        return view
    }()
    
    
    lazy var iphone = PVItem(identifier: Identifier.iphoneBase, target: iphoneView)
    lazy var screen1 = PVItem(identifier: Identifier.screen1, target: UIImageView(image: #imageLiteral(resourceName: "screen_01")), container: iphoneScreenView)
    lazy var popup1 = PVItem(identifier: Identifier.popup1, target: UIImageView(image: #imageLiteral(resourceName: "screen_01_popup1")), container: iphoneView)
    lazy var popup2 = PVItem(identifier: Identifier.popup2, target: UIImageView(image: #imageLiteral(resourceName: "screen_01b_popup2")), container: iphoneView)
    
    lazy var screen2 = PVItem(identifier: Identifier.screen2, target: UIImageView(image: #imageLiteral(resourceName: "screen_02")), container: iphoneScreenView)
    lazy var searchBubble = PVItem(identifier: Identifier.searchBubble, target: UIImageView(image: #imageLiteral(resourceName: "screen_02_bubble")), container: iphoneView)
    lazy var screen3 = PVItem(identifier: Identifier.screen3, target: UIImageView(image: #imageLiteral(resourceName: "screen_03")), container: iphoneScreenView)
    lazy var screen4 = PVItem(identifier: Identifier.screen4, target: UIImageView(image: #imageLiteral(resourceName: "screen_04")), container: iphoneScreenView)
    lazy var taskBubble = PVItem(identifier: Identifier.taskBubble, target: UIImageView(image: #imageLiteral(resourceName: "screen_04_bubble")), container: iphoneView)
    let contactIcon = PVItem(identifier: Identifier.contactIcon, target: UIImageView(image: #imageLiteral(resourceName: "screen_03_contact")))
    let messageIcon = PVItem(identifier: Identifier.messageIcon, target: UIImageView(image: #imageLiteral(resourceName: "screen_03_msg")))
    let callingIcon = PVItem(identifier: Identifier.callingIcon, target: UIImageView(image: #imageLiteral(resourceName: "screen_03_phone")))
    lazy var screen5 = PVItem(identifier: Identifier.screen5, target: UIImageView(image: #imageLiteral(resourceName: "screen_05_iphone")), container: iphoneScreenView)
    let iPad = PVItem(identifier: Identifier.iPad, target: UIImageView(image: #imageLiteral(resourceName: "screen_05_ipad")))
    let iMac = PVItem(identifier: Identifier.iMac, target: UIImageView(image: #imageLiteral(resourceName: "screen_05_imac")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.2862730569, green: 0.8505314086, blue: 0.5361324761, alpha: 1)
        view.addSubview(parallaxView)
        NSLayoutConstraint.activate([parallaxView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     parallaxView.topAnchor.constraint(equalTo: view.topAnchor),
                                     parallaxView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     parallaxView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        prepare()
        parallaxView.reload()
    }
    
    func prepare() {
        pages = [loadPage0(), loadPage1(), loadPage2(), loadPage3()]
    }
    
    func loadPage0() -> [Element] {
        let iphoneActions = [PVActionRotate(fromZ: 0, toZ: -Double.pi / 5), PVActionRotate(fromY: 0, toY: -Double.pi / 6)]
        let popupScale = PVActionScale(from: 1, to: 0)
        popupScale.endOffset = 0.5
        let popup1Actions = [popupScale]
        let popup2Actions = popup1Actions
        let bubbleActionGroup = PVActionGroup(actions: [PVActionScale(from: 0, to: 1.8),
                                                        PVActionFade(from: 0, to: 1),
                                                        PVActionMove(fromPosition: PVPoint(x: 0.5, y: 0.1, isRelative: true),
                                                                     toPosition: PVPoint(x: -0.2, y: 0.6, isRelative: true))])
        bubbleActionGroup.startOffset = 0.5
        let bubbleActions = [bubbleActionGroup]
        let screen1Actions = [PVActionFrame(fromFrame: iphoneScreenView.bounds, toFrame: iphoneScreenView.bounds.offsetBy(dx: iphoneScreenView.bounds.width - 20, dy: 0))]
        
        return [(iphone, iphoneActions),
                (popup1, popup1Actions),
                (popup2, popup2Actions),
                (searchBubble, bubbleActions),
                (screen2, []),
                (screen1, screen1Actions)]
    }
    
    func loadPage1() -> [Element] {
        let iphoneActions = [PVActionRotate(fromZ: -Double.pi / 5, toZ: 0), PVActionRotate(fromY: -Double.pi / 6, toY: 0), PVActionRotate(fromX: 0, toX: -Double.pi / 5)]
        let screen3Actions = [PVActionFrame(fromFrame: iphoneScreenView.bounds.offsetBy(dx: iphoneScreenView.bounds.width - 20, dy: 0), toFrame: iphoneScreenView.bounds)]
        let bubbleActionGroup = PVActionGroup(actions: [PVActionScale(from: 1.8, to: 0),
                                                        PVActionFade(from: 1, to: 0),
                                                        PVActionMove(fromPosition: PVPoint(x: -0.2, y: 0.6, isRelative: true),
                                                                     toPosition: PVPoint(x: 0.5, y: 0.1, isRelative: true))])
        bubbleActionGroup.endOffset = 0.5
        
        let contactActionGroup = PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: -50.0, y: -50))])
        contactActionGroup.startOffset = 0.6
        let messageActionGroup = PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: 0, y: -100))])
        messageActionGroup.startOffset = 0.7
        let callingActionGroup = PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: 50, y: -50))])
        callingActionGroup.startOffset = 0.8
        
        return [(contactIcon, [contactActionGroup]), (messageIcon, [messageActionGroup]), (callingIcon, [callingActionGroup]), (iphone, iphoneActions), (screen3, screen3Actions), (searchBubble, [bubbleActionGroup])]
    }
    
    func loadPage2() -> [Element] {
        let iconScale = PVActionScale(from: 1.5, to: 0)
        let contactActionGroup = PVActionGroup(actions: [iconScale, PVActionMove(fromTranslation: PVPoint(x: -50.0, y: -50), toTranslation: PVPoint.zero)])
        contactActionGroup.endOffset = 0.4
        let messageActionGroup = PVActionGroup(actions: [iconScale, PVActionMove(fromTranslation: PVPoint(x: 0, y: -100), toTranslation: PVPoint.zero)])
        messageActionGroup.endOffset = 0.5
        let callingActionGroup = PVActionGroup(actions: [iconScale, PVActionMove(fromTranslation: PVPoint(x: 50, y: -50), toTranslation: PVPoint.zero)])
        callingActionGroup.endOffset = 0.6
        
        let screen4Actions = [PVActionMove(fromOrigin: PVPoint(x: 0, y: 1, isRelative: true), toOrigin: PVPoint.zero)]
        let iphoneActions = [PVActionRotate(fromZ: 0, toZ: Double.pi / 5), PVActionRotate(fromY: 0, toY: Double.pi / 6), PVActionRotate(fromX: -Double.pi / 5, toX: 0)]
        let bubbleActionGroup = PVActionGroup(actions: [PVActionScale(from: 0, to: 1.8), PVActionFade(from: 0, to: 1), PVActionMove(fromPosition: PVPoint(x: 0.2, y: 0.3, isRelative: true), toPosition: PVPoint(x: 1.0, y: 0.6, isRelative: true))])
        bubbleActionGroup.startOffset = 0.7
        return [(contactIcon, [contactActionGroup]), (messageIcon, [messageActionGroup]), (callingIcon, [callingActionGroup]), (screen4, screen4Actions), (iphone, iphoneActions), (taskBubble, [bubbleActionGroup])]
    }
    
    func loadPage3() -> [Element] {
        let midX = Double(UIScreen.main.bounds.midX)
        let midY = Double(UIScreen.main.bounds.midY)
        let iphoneActions = [PVActionRotate(fromZ: Double.pi / 5, toZ: 0), PVActionRotate(fromY: Double.pi / 6, toY: 0), PVActionScale(from: 1.0, to: 0.3), PVActionMove(fromPosition: PVPoint(x: midX, y: midY), toPosition: PVPoint(x: midX - 70, y: midY + 50))]
        let screen5Actions = [PVActionFade(from: 0, to: 1)]
        let iMacActions = [PVActionScale(from: 1, to: 1.5), PVActionFade(from: 0, to: 1), PVActionMove(fromPosition: PVPoint(x: midX - 100, y: midY), toPosition: PVPoint(x: midX, y: midY))]
        let iPadActions = [PVActionScale(from: 1, to: 1.3), PVActionFade(from: 0, to: 1), PVActionMove(fromPosition: PVPoint(x: midX + 100, y: midY + 35), toPosition: PVPoint(x: midX + 75, y: midY + 35))]
        let bubbleActionGroup = PVActionGroup(actions: [PVActionScale(from: 1.8, to: 0), PVActionFade(from: 1, to: 0), PVActionMove(fromPosition: PVPoint(x: 1.0, y: 0.6, isRelative: true), toPosition: PVPoint(x: 0.2, y: 0.3, isRelative: true))])
        bubbleActionGroup.endOffset = 0.4
        iPad.target.layer.zPosition = 1000
        return [(iMac, iMacActions), (iPad, iPadActions), (iphone, iphoneActions), (screen5, screen5Actions), (taskBubble, [bubbleActionGroup])]
    }
    
    func willAppearPage0() {
        iphone.target.layer.transform = CATransform3DIdentity
        iphone.target.layer.position = view.center
        iphone.target.layer.transform.m34 = 1.0 / 500
        iphone.target.layer.zPosition = 100
        
        popup1.target.center = CGPoint(x: iphone.target.bounds.width, y: 40)
        popup1.target.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.popup1.target.transform =  CGAffineTransform.identity
        })
        
        popup2.target.center = CGPoint(x: 0, y: iphone.target.bounds.midY)
        popup2.target.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseInOut, animations: {
            self.popup2.target.transform =  CGAffineTransform.identity
        })
    }
    
    func willAppearPage1() {
        [contactIcon, messageIcon, callingIcon].forEach { $0.target.layer.zPosition = 1000 } //make sure icon is always on top of iphoneView
        contactIcon.target.layer.position = CGPoint(x: parallaxView.bounds.midX - 40, y: parallaxView.bounds.midY - 15)
        messageIcon.target.layer.position = CGPoint(x: parallaxView.bounds.midX, y: parallaxView.bounds.midY - 15)
        callingIcon.target.layer.position = CGPoint(x: parallaxView.bounds.midX + 40, y: parallaxView.bounds.midY - 15)
    }
}

extension ViewController: PVViewDelegate {
    func numberOfPages(in parallaxView: PVView) -> Int {
        return pages.count
    }
    
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int) {
        if parallaxView.currentPageIndex == 1 && pageIndex == 0 {
            if let screen3 = parallaxView.itemOnCurrentPage(by: Identifier.screen3) {
                screen3.target.frame = iphoneScreenView.bounds.offsetBy(dx: iphoneScreenView.bounds.width, dy: 0)
            }
        }
    }
    
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItem] {
        return pages[pageIndex].map { $0.item }
    }
    
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItem, onPage pageIndex: Int) -> [PVAction] {
        return pages[pageIndex].first(where: { $0.item == item })?.actions ?? []
    }
    
    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?) {
        guard let currentIndex = parallaxView.currentPageIndex else { return }
        if currentIndex == 0 && previousPageIndex == nil {
            willAppearPage0()
        }
        
        if currentIndex == 1 && previousPageIndex == 0 {
            willAppearPage1()
        }
    }
}

