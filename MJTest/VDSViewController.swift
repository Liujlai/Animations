//
//  VDSViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/17.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class VDSViewController: UIViewController {
    lazy var btn: UIButton = {
        let btn = UIButton()
        return btn.str("✘").color(kAppColor).font(38).pin(.xy(20,20)).onClick({[weak self] _ in
            //            self!.dismiss(animated: true, completion: nil)
            self?.navigationController?.popViewController(animated: true)
        })
    }()
    lazy var img1: UIImageView = {
        return ImageView.border(4, kRandom).pin(120,90).img("4")
    }()
    lazy var img2: UIImageView = {
        return ImageView.border(2, kRandom).pin(120,90).img("5").radius(8)
    }()
    lazy var img3: UIImageView = {
        return ImageView.border(2, kRandom).pin(120,90).img("4")
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bg(kWhiteColor)
        view.addSubviews(btn,img1,img2,img3)
        
        img1.makeCons {
            $0.top.equal(50)
            $0.centerX.equal(0)
        }
        img2.makeCons {
            $0.center.equal(0)
        }
        
        img3.makeCons {
            $0.bottom.equal(-50)
            $0.left.equal(50)
        }
        
        
        VDSAnimation.shared.setupAnimation(in: self.view, imageView: img1)
        VDSAnimation.shared.setupAnimation(in: self.view, imageView: img2)
        VDSAnimation.shared.setupAnimation(in: self.view, imageView: img3)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
