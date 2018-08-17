//
//  DetailViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import ChainableAnimations
import DWAnimatedLabel
class DetailViewController: UIViewController {
    
    lazy var btn: UIButton = {
        let btn = UIButton()
        return btn.str("✘").color(kAppColor).font(38).pin(.xy(20,20)).onClick({[weak self] _ in
            self!.dismiss(animated: true, completion: nil)
        })
    }()
    lazy var botBtn: UIButton = {
        let botBtn = UIButton()
        return botBtn.str("➣").color(kAppColor).font(45).pin(.maxXY(-20, -10)).onClick({[weak self] _ in
            self!.setupAnimator()
        })
    }()
    lazy var tipsLab: UILabel = {
        
        return Label.str("向左滑动或点击箭头换页").color(kAppColor)
    }()
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.alpha=0.4
        return img
    }()
    lazy var titlelab: DWAnimatedLabel = {
        let titlelab = DWAnimatedLabel()
        titlelab.animationType = .fade
        titlelab.placeHolderColor = .blue
        return titlelab.bg(kBlackColor+",0.5")
            .font("24")
            .radius(8)
            .align(.center)
            .lines()
            .color(kWhiteColor)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bg(kWhiteColor)
        view.addSubviews(btn,botBtn,img,titlelab,tipsLab)
        setupUI()
        setupGesture()
        titlelab.startAnimation(duration: 1.5, nil)
    }
    func setupUI() {
        img.makeCons { (make) in
            make.edge.equal(0)
        }
        titlelab.makeCons { (make) in
            make.center.equal(0)
            make.left.equal(40)
            make.top.equal(80)
        }
        titlelab.text = KPLACEHOLDER
        
        tipsLab.makeCons {
            $0.centerX.equal(0)
            $0.centerY.equal(botBtn)
        }
    }
    func setupGesture(){
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swip:)))
        //设置滑动方向
        //如果UISwipeGestureRecognizer在不指定方向的时候，默认向右滑动才会触发事件。如果要指定方向，需要设置direction属性
        swip.direction = .left
        self.view.addGestureRecognizer(swip)
        // 点击手势
        titlelab.onClick {[unowned self] tit in
            
            let viewController = CardsViewController()
            viewController.cc_setZoomTransition(originalView: tit)
            self.present(viewController, animated: true, completion: nil)
        }
    }
    @objc func swipeGesture(swip:UISwipeGestureRecognizer) {
        print("开始滑动")
        self.setupAnimator()
    }
    
    func setupAnimator(){
        let animator = ChainableAnimator(view: titlelab)
        animator.move(x: -500).spring.easeIn.thenAfter(t: 0.5).make(alpha: 0.0).animate(t: 0.5);
        animator.completion = {
            animator.move(x: 800).thenAfter(t: 0.1).move(x: -300).easeIn.make(alpha: 1.0).animate(t: 0.5);
        }
        titlelab.startAnimation(duration: 1.5, nil)
    }
    
}
