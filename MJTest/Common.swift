//
//  Common.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import Foundation
@_exported import Cupcake
//屏幕的宽度
let kScreenW = UIScreen.main.bounds.size.width
//屏幕的高度
let kScreenH = UIScreen.main.bounds.size.height
//是否是真机
let isIPhone: Bool = {
    return (UI_USER_INTERFACE_IDIOM() == .phone)
}()

//颜色
let kAppColor    = "#00C6B0"
let kLineColor   = "#a8a8a8"
let kWhiteColor  = "#ffffff"
let kShadowColor = "#4a4a4a"
let kRandom     = "random" //随机颜色
