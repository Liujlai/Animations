//
//  CardsViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import ChainableAnimations
class CardsViewController: UIViewController {

    lazy var btn: UIButton = {
        let btn = UIButton()
        return btn.str("✘").color(kAppColor).font(38).pin(.xy(20,20)).onClick({[weak self] _ in
            self!.dismiss(animated: true, completion: nil)
        })
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubviews(btn)
    }

}
