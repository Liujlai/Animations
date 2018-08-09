//
//  SideView.swift
//  MJTest
//
//  Created by idea on 2018/8/8.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class SideView: UIView {

    lazy var icon: UIImageView = {
        return ImageView.border(2, kWhiteColor)
    }()
    lazy var titlelab: UILabel = {
        return Label.color(kWhiteColor).font(24).align(.center)
    }()
    
    lazy var sublab: UILabel = {
        return Label.color(kWhiteColor).font(18).align(.center).lines(0)
    }()
    lazy var setbtn: UIButton = {
        return Button.color(kAppColor).font(38)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(icon,titlelab,sublab,setbtn)
        icon.makeCons {
            $0.centerX.equal(0)
            $0.top.equal(80)
            $0.width.height.equal(80)
        }
        titlelab.makeCons {
            $0.top.equal(icon).bottom.offset(40)
            $0.left.equal(15)
            $0.right.equal(-15)
        }
        sublab.makeCons {
            $0.top.equal(titlelab).bottom.offset(30)
            $0.left.equal(15)
            $0.right.equal(-15)
        }
        setbtn.makeCons {
            $0.bottom.equal(-20)
            $0.right.equal(-20)
        }
    }
    func reloadData(_ img:String,_ title:String,_ sub:String,_ set:Any){
        icon.sd_setImage(with: URL(string: img), placeholderImage: #imageLiteral(resourceName: "noNet"))
        icon.radius(10)
        titlelab.text = title
        sublab.text = sub
        setbtn.str(set)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
