//
//  StackView.swift
//  swift_D
//
//  Created by idea on 2018/7/28.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import SDWebImage
class StackView: UIButton {
//    let s = Styles.color(kWhiteColor)
    lazy var memoLabel:UILabel = {
        return Label.font("15")
        .color(kWhiteColor)
            .shadow(1.0,0,1,1,kShadowColor)
        
    }()
    lazy var nameLabel:UILabel = {
        return Label.font(20)
            .color(kWhiteColor)
            .shadow(1.0,0,1,1,kShadowColor) 
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews(memoLabel,nameLabel)
        memoLabel.makeCons { make in
            make.centerX.equal(self)
            make.centerY.equal(self).bottom.offset(-50-100)
        }
        nameLabel.makeCons {
            $0.centerX.equal(self)
            $0.bottom.equal(self).offset(-50)
        }
    }
    
    var model:StackModel!{
        willSet(newValue){
            self.memoLabel.text = newValue.desc
            self.memoLabel.alpha = 0.0
            self.sd_setImage(with: URL(string: newValue.imageUrl!), for: .normal, placeholderImage: #imageLiteral(resourceName: "noNet"), options: .retryFailed, completed: nil)
            self.nameLabel.text = newValue.title
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    定义共有属性
//    func commonLabStyle(_ l:UILabel)  {
//       l.color(kWhiteColor)
//        .shadow(1.0,0,1,1,kShadowColor) //shadow()中的值分别为：opacity（不透明度）, radius (optional), offset (optional) and color (optional).
//    }
}
