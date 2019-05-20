//
//  ViewController.swift
//  PVViewDemo
//
//  Created by Toan Nguyen on 5/2/19.
//  Copyright © 2019 TNT. All rights reserved.
//

import UIKit
import PVView

class ViewController: UIViewController {
    typealias Element = (item: ParallaxItem, actions: [PVActionType])
    var pages: [[Element]]!
    var itemViews = [String: UIView]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var parallaxView: PVView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxView.ignoreLastPage = true
        parallaxView.delegate = self
        self.loadActions()
        startParallaxView()
    }
    
    func startParallaxView() {
        pageControl.numberOfPages = pages.count
        self.loadItemViews()
        parallaxView.reload()
    }
    
    private func loadItemViews() {
        itemViews = [:]
        let iphoneImage = #imageLiteral(resourceName: "iphone_base")
        let iphoneView = UIView(frame: CGRect(origin: CGPoint(x: view.center.x - iphoneImage.size.width / 2, y: view.center.y - iphoneImage.size.height / 2), size: iphoneImage.size))
        let iphoneBgrView = UIImageView(image: iphoneImage)
        iphoneBgrView.frame = iphoneView.bounds
        iphoneView.addSubview(iphoneBgrView)
        iphoneView.isUserInteractionEnabled = false
        iphoneView.backgroundColor = UIColor.clear
        iphoneView.layer.transform.m34 = 1.0 / 500 //This make iphoneView has 3D rotating
        iphoneView.layer.zPosition = 50
        let iphoneScreenView = UIView(frame: iphoneView.bounds.insetBy(dx: 10, dy: 37))
        iphoneScreenView.layer.masksToBounds = true
        iphoneView.addSubview(iphoneScreenView)
        
        itemViews[ParallaxItem.iphoneBase.identifier] = iphoneView
        itemViews["iphoneScreen"] = iphoneScreenView
        itemViews[ParallaxItem.screen1.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_01"))
        itemViews[ParallaxItem.screen2.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_02"))
        itemViews[ParallaxItem.screen3.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_03"))
        itemViews[ParallaxItem.screen4.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_04"))
        itemViews[ParallaxItem.screen5.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_05_iphone"))
        itemViews[ParallaxItem.searchBubble.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_02_bubble"))
        itemViews[ParallaxItem.taskBubble.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_04_bubble"))
        itemViews[ParallaxItem.iPad.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_05_ipad"))
        itemViews[ParallaxItem.iMac.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_05_imac"))
        itemViews[ParallaxItem.popup1.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_01_popup1"))
        itemViews[ParallaxItem.popup2.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_01b_popup2"))
        itemViews[ParallaxItem.contactIcon.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_03_contact"))
        itemViews[ParallaxItem.messageIcon.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_03_msg"))
        itemViews[ParallaxItem.callingIcon.identifier] = UIImageView(image: #imageLiteral(resourceName: "screen_03_phone"))
        itemViews[ParallaxItem.label1.identifier] = UILabel(frame: CGRect.zero)
        itemViews[ParallaxItem.label2.identifier] = UILabel(frame: CGRect.zero)
        itemViews[ParallaxItem.label3.identifier] = UILabel(frame: CGRect.zero)
        itemViews[ParallaxItem.label4.identifier] = UILabel(frame: CGRect.zero)
        
        //Config initial information if needed
        [(ParallaxItem.popup1, CGPoint(x: iphoneView.bounds.width, y: 40)),
         (.popup2, CGPoint(x: 0, y: iphoneView.bounds.midY)),
         (.contactIcon, CGPoint(x: view.center.x - 40, y: view.center.y - 15)),
         (.messageIcon, CGPoint(x: view.center.x, y: view.center.y - 15)),
         (.callingIcon, CGPoint(x: view.center.x + 40, y: view.center.y - 15))].forEach { (item, center) in
            itemViews[item.identifier]?.center = center
        }
        
        [ParallaxItem.contactIcon, .messageIcon, .callingIcon, .iPad].forEach {
            itemViews[$0.identifier]?.layer.zPosition = 1000
        }
        
        [(ParallaxItem.label1, "👋 Welcome to the ParallaxView 👋"),
         (.label2, "Easy implementation 😍"),
         (.label3, "Full customization 🤩"),
         (.label4, "Let's do something cool 😎")].forEach { (item, text) in
            let label = itemViews[item.identifier] as! UILabel
            label.text = text
            label.font = UIFont.systemFont(ofSize: 20)
            label.textAlignment = .center
            label.frame.size = label.sizeThatFits(CGSize(width: self.view.bounds.width - 40, height: 50))
        }
        
    }
    
    func loadActions() {
        //Page 0
        let p0_iphone = [PVActionRotate(toZ: -Double.pi / 5), PVActionRotate(toY: -Double.pi / 6)]
        let p0_popup1 = [PVActionScale(to: 0, parameters: PVParameters(stopOffset: 0.5))]
        let p0_popup2 = p0_popup1
        let p0_bubble = [PVActionGroup(actions: [PVActionScale(from: 0, to: 1.8),
                                                PVActionFade(from: 0),
                                                PVActionMove(fromPosition: PVPoint(x: 0.5, y: 0.1, isRelative: true),
                                                             toPosition: PVPoint(x: -0.2, y: 0.6, isRelative: true))],
                                      parameters: PVParameters(startOffset: 0.5))]
        let p0_label1: [PVActionBasicType] = [PVActionFade(from: 0), PVActionMove(fromPosition: PVPoint(x: 1.5, y: 0.2, isRelative: true), toPosition: PVPoint(x: 0.5, y: 0.2, isRelative: true))]
        let p0_screen1 = [PVActionMove(toTranslation: PVPoint(x: 0.86, y: 0, isRelative: true))]
        
        let page0: [Element] = [(.iphoneBase, p0_iphone),
                     (.popup1, p0_popup1),
                     (.popup2, p0_popup2),
                     (.searchBubble, p0_bubble),
                     (.screen2, []),
                     (.screen1, p0_screen1),
                     (.label1, p0_label1)]
        
        //Page 1
        let p1_iphone = p0_iphone.reversedActions() + [PVActionRotate(toX: -Double.pi / 5)]
        let p1_screen3 = p0_screen1.reversedActions()
        let p1_bubble = p0_bubble.reversedActions(with: PVParameters(stopOffset: 0.5))
        let p1_contact = [PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: -50.0, y: -50))], parameters: PVParameters(startOffset: 0.6))]
        let p1_message = [PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: 0, y: -100))], parameters: PVParameters(startOffset: 0.7))]
        let p1_calling = [PVActionGroup(actions: [PVActionScale(from: 0, to: 1.5), PVActionMove(toTranslation: PVPoint(x: 50, y: -50))], parameters: PVParameters(startOffset: 0.8))]
        let p1_label1: [PVActionBasicType] = [PVActionFade(to: 0), PVActionMove(fromPosition: PVPoint(x: 0.5, y: 0.2, isRelative: true), toPosition: PVPoint(x: -0.5, y: 0.2, isRelative: true))]
        let p1_label2 = p0_label1
        let page1: [Element] = [(.iphoneBase, p1_iphone),
                                (.screen3, p1_screen3),
                                (.searchBubble, p1_bubble),
                                (.contactIcon, p1_contact),
                                (.messageIcon, p1_message),
                                (.callingIcon, p1_calling),
                                (.label1, p1_label1),
                                (.label2, p1_label2)]
        
        //Page 2
        let p2_contact = p1_contact.reversedActions(with: PVParameters(stopOffset: 0.4))
        let p2_message = p1_message.reversedActions(with: PVParameters(stopOffset: 0.5))
        let p2_calling = p1_calling.reversedActions(with: PVParameters(stopOffset: 0.6))
        let p2_screen4 = [PVActionMove(fromOrigin: PVPoint(x: 0, y: 1, isRelative: true), toOrigin: PVPoint.zero)]
        let p2_iphone = [PVActionRotate(toZ: Double.pi / 5), PVActionRotate(toY: Double.pi / 6), PVActionRotate(fromX: -Double.pi / 5)]
        let p2_bubble = [PVActionGroup(actions: [PVActionScale(from: 0, to: 1.8), PVActionFade(from: 0), PVActionMove(fromPosition: PVPoint(x: 0.2, y: 0.3, isRelative: true), toPosition: PVPoint(x: 1.0, y: 0.6, isRelative: true))], parameters: PVParameters(startOffset: 0.7))]
        let p2_label2 = p1_label1
        let p2_label3 = p0_label1
        let page2: [Element] = [(.contactIcon, p2_contact),
                                (.messageIcon, p2_message),
                                (.callingIcon, p2_calling),
                                (.screen4, p2_screen4),
                                (.iphoneBase, p2_iphone),
                                (.taskBubble, p2_bubble),
                                (.label2, p2_label2),
                                (.label3, p2_label3)]
        
        //Page 3
        let midX = Double(UIScreen.main.bounds.midX)
        let midY = Double(UIScreen.main.bounds.midY)
        let p3_iphone: [PVActionBasicType] = [PVActionRotate(fromZ: Double.pi / 5), PVActionRotate(fromY: Double.pi / 6), PVActionScale(to: 0.3), PVActionMove(fromPosition: PVPoint(x: midX, y: midY), toPosition: PVPoint(x: midX - 70, y: midY + 50))]
        
        let p3_screen5 = [PVActionFade(from: 0)]
        
        let p3_iMac: [PVActionBasicType] = [PVActionScale(to: 1.5), PVActionFade(from: 0), PVActionMove(fromPosition: PVPoint(x: midX - 100, y: midY), toPosition: PVPoint(x: midX, y: midY))]
        
        let p3_iPad: [PVActionBasicType] =  [PVActionScale(to: 1.3), PVActionFade(from: 0), PVActionMove(fromPosition: PVPoint(x: midX + 100, y: midY + 35), toPosition: PVPoint(x: midX + 75, y: midY + 35))]
        let p3_bubble = p2_bubble.reversedActions(with: PVParameters(stopOffset: 0.4))
        let p3_label3 = p1_label1
        let p3_label4 = p0_label1
        let page3: [Element] = [(.iMac, p3_iMac),
                                (.iPad, p3_iPad),
                                (.iphoneBase, p3_iphone),
                                (.screen5, p3_screen5),
                                (.taskBubble, p3_bubble),
                                (.label3, p3_label3),
                                (.label4, p3_label4)]
        
        pages = [page0, page1, page2, page3, []]
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        startParallaxView()
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        parallaxView.next()
    }
    @IBAction func backPage(_ sender: UIButton) {
        parallaxView.back()
    }
}

extension ViewController: PVViewDelegate {
    func direction(of parallaxView: PVView) -> PVView.PVDirection {
        return segmentedControl.selectedSegmentIndex == 0 ? .horizontal : .vertical
    }
    func numberOfPages(in parallaxView: PVView) -> Int {
        return pages.count
    }
    
    func parallaxView(_ parallaxView: PVView, willBeginTransitionTo pageIndex: Int) {

    }
    
    func parallaxView(_ parallaxView: PVView, itemsOnPage pageIndex: Int) -> [PVItemType] {
        return pages[pageIndex].map { $0.item }
    }
    
    func parallaxview(_ parallaxView: PVView, viewForItem item: PVItemType) -> UIView {
        return itemViews[item.identifier]!
    }
    
    func parallaxView(_ parallaxView: PVView, containerViewForItem item: PVItemType, onPage pageIndex: Int) -> UIView? {
        let item = item as! ParallaxItem
        switch item {
        case .screen1, .screen2, .screen3, .screen4, .screen5:
            return itemViews["iphoneScreen"]
        case .popup1, .popup2, .searchBubble, .taskBubble:
            return itemViews[ParallaxItem.iphoneBase.identifier]
        default:
            return nil
        }
    }
    
    func parallaxView(_ parallaxView: PVView, actionsOfItem item: PVItemType, onPage pageIndex: Int) -> [PVActionType] {
        return pages[pageIndex].first(where: { $0.item.identifier == item.identifier })?.actions ?? []
    }

    func parallaxView(_ parallaxView: PVView, didEndTransitionFrom previousPageIndex: Int?) {
        guard let currentIndex = parallaxView.currentPageIndex else { return }
        pageControl.currentPage = currentIndex
        if currentIndex == 0 && previousPageIndex == nil {
            if let popup1 = parallaxView.viewForItem(by: ParallaxItem.popup1.identifier) {
                popup1.transform = CGAffineTransform(scaleX: 0, y: 0)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    popup1.transform =  CGAffineTransform.identity
                })
            }
            
            if let popup2 = parallaxView.viewForItem(by: ParallaxItem.popup2.identifier) {
                popup2.transform = CGAffineTransform(scaleX: 0, y: 0)
                UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseInOut, animations: {
                    popup2.transform =  CGAffineTransform.identity
                })
            }
        }
    }
}

