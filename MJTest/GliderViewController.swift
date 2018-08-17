//
//  GliderViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/14.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import ChainableAnimations
import RDGliderViewController_Swift
class GliderViewController: UIViewController {

    var bottomToTopGlideVC: RDGliderViewController?

    lazy var gliderBtn: UIButton = {
        let gliderBtn = UIButton()
        return gliderBtn.str("⌽").color(kAppColor).font(38).pin(.maxX(-20),.y(20)).onClick({[weak self] _ in
            self!.navigationController?.pushViewController(VDSViewController(), animated: true)
        })
    }()
    lazy var lab: UILabel = {
        return Label.str("点").font("72").color(kRandom).border(5, kAppColor).radius(10).onClick({[weak self] _ in
            self!.setglider()
        })
    }()
    lazy var lab1: UILabel = {
        return Label.str("点").font("72").color(kRandom).border(5, kAppColor).radius(10)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(gliderBtn,lab)
        initBottomToTopGlideView()
        
        lab.makeCons {
            $0.bottom.equal(-400+42)
            $0.centerX.equal()
        }
    }
    
    func initBottomToTopGlideView() {
        let content: RDGliderContentViewController = RDGliderContentViewController.init(length: 400.0)
        content.view.backgroundColor = UIColor.purple
        content.showShadow = true
        content.cornerRadius = 10.0
        
        content.view.addSubviews(lab1)
        lab1.makeCons {
            $0.top.equal(-42)
            $0.centerX.equal()
        }
        
        self.bottomToTopGlideVC = RDGliderViewController.init(parent: self,
                                                              WithContent: content,
                                                              AndType: .RDScrollViewOrientationBottomToTop,
                                                              WithOffsets: [0.6, 0, 0.3, 1])
        self.bottomToTopGlideVC?.delegate = self
    }
    
    func setglider() {
        let animator = ChainableAnimator(view: gliderBtn)
        animator.rotate(angle: -90).animate(t: 0.2);
        let gliderVC: RDGliderViewController = bottomToTopGlideVC!
        if gliderVC.currentOffsetIndex < Int(gliderVC.offsets.count) - 1 {
            gliderVC.expand()
        } else {
            gliderVC.shake()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension GliderViewController: RDGliderViewControllerDelegate {
    func glideViewControllerWillExpand(glideViewController: RDGliderViewController) {
        print("Will Expand")
    }
    
    func glideViewControllerDidExpand(glideViewController: RDGliderViewController) {
        print("Did Expand")
    }
    
    func glideViewControllerWillCollapse(glideViewController: RDGliderViewController) {
        print("Will Collapse")
    }
    
    func glideViewControllerDidCollapse(glideViewController: RDGliderViewController) {
        print("Did Collapse")
    }
    
    func glideViewController(glideViewController: RDGliderViewController, hasChangedOffsetOfContent offset: CGPoint) {
        print("New Offset: " + NSStringFromCGPoint(offset))
    }
}
