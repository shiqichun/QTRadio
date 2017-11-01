//
//  Constant.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/**
 
 控制器view的frame：
 在iPhone X中，控制器view的frame是(0.0, 0.0, 375.0, 812.0)
 在iPhone 8中，控制器view的frame是(0.0, 0.0, 375.0, 667.0)
 
 
 navigationBar的frame：
 X: (0.0, 44.0, 375.0, 44.0)
 8: (0.0, 20.0, 375.0, 44.0)
 
 在iPhone X中，状态栏的高度是44，navigationBar的高度是44，二者合起来是88
 在iPhone 8中，状态栏的高度是20，navigationBar的高度依然是44，二者合起来是64
 
 
 tabBar的frame：
 X: (0.0, 763.0, 375.0, 49.0)
 8: (0.0, 618.0, 375.0, 49.0)
 
 在iPhone X中，tabBar的y值是763(刚好是812-49)，高度是49
 在iPhone 8中，tabBar的y值时618(刚好是667-49)，高度依然是49
 
 */


/// 屏幕的宽度
let kScreenWidth: CGFloat = UIScreen.main.bounds.width


/// 屏幕的高度
let kScreenHeight: CGFloat = UIScreen.main.bounds.height


/// 适配iPhone X
let isIphoneX = (kScreenWidth == 375.0 && kScreenHeight == 812.0 ? true : false)


/// 状态栏的高度
let kStatusBarHeight: CGFloat = isIphoneX ? 44.0 : 20.0  // iPhone X的statusBar高度增加了22


/// 导航栏的高度
let kNavigationBarHeight: CGFloat = 44.0


/// tabBar的高度
let kTabBarHeight: CGFloat = 49.0  // iPhone X底部增加了34


/// tabBar距离底部的距离
let kTabBarMargin: CGFloat = isIphoneX ? 34.0 : 0


/// tabBar正中间播放按钮的背景View控件的宽度和高度
let kPlayButtonViewWidth: CGFloat = 65
let kPlayButtonViewHeight: CGFloat = kPlayButtonViewWidth

