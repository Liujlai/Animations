//
//  StackModel.swift
//  swift_D
//
//  Created by idea on 2018/7/28.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class StackModel: NSObject {
    var title: String?
    var desc: String?
    var imageUrl: String?
    
    init(title:String, desc:String, imageUrl:String) {
        self.title = title
        self.desc = desc
        self.imageUrl = imageUrl
    }
}
