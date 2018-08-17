//
//  CardsViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import ChainableAnimations
import DWAnimatedLabel
class CardsViewController: UIViewController {

    lazy var btn: UIButton = {
        let btn = UIButton()
        return btn.str("✘").color(kAppColor).font(38).pin(.xy(20,20)).onClick({[weak self] _ in
            self!.dismiss(animated: true, completion: nil)
        })
    }()
    lazy var gliderBtn: UIButton = {
        let gliderBtn = UIButton()
        return gliderBtn.str("⌽").color(kAppColor).font(38).pin(.maxX(-20),.y(20)).onClick({[weak self] _ in
            Alert.message("⌽⌽⌽⌽⌽").action("en").show()
        })
    }()
    lazy var lab: DWAnimatedLabel = {
        let lab = DWAnimatedLabel()
        lab.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        lab.animationType = .shine
        lab.placeHolderColor = .gray
        return lab.bg("black").color(kWhiteColor).lines().align(.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubviews(btn,gliderBtn)
        lab.text = KPLACEHOLDER
        view.addSubview(lab)
        lab.makeCons { (make) in
            make.top.equal(64)
            make.left.right.bottom.equal(0)
        }
        lab.startAnimation(duration: 4.0, nil)
        
    }
    

    
    
}
