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
let kBlackColor  = "#000000"
let kShadowColor = "#4a4a4a"
let kRandom      = "random" //随机颜色


//文本

let KPLACEHOLDER = """
天地匆匆
惊鸿而过

遑遑无归
闲云逸鹤

引势而流
鸿门乱局

丹歌起势 同风而起

卧龙低伏 入我阵来
"""

//1.如果真机上动画在结束后闪烁在JHAnimationChainLink.m文件146行下加入以下代码
//self.animationGroup.fillMode = kCAFillModeForwards;
//self.animationGroup.removedOnCompletion = NO;  ///修改真机动画完成后闪烁的问题

//2.DWAnimatedLabel 加载动画时cpu percentage used 会在90%⇡


