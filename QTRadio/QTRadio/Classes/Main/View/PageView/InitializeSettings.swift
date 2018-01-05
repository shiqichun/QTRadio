//
//  InitializeSettings.swift
//  PageView
//
//  Created by Enrica on 2018/1/5.
//  Copyright © 2018年 Enrica. All rights reserved.
//

import UIKit

class InitializeSettings {

    // MARK: - 和标题TitleView相关的属性
    
    
    /**
     *  1、TitleView通用属性
     */
    
    /// 标题的背景颜色
    var titleBackgroundColor = UIColor.white
    
    /// 标题TitleView的高度(如果外界不传，默认为44)
    var titleViewHeight: CGFloat = 44
    
    /// 标题TitleView是否可以滚动(默认为不可以滚动)
    var isScrollEnable: Bool = false
    
    /// 标题TitleView可以滚动时，label之间的间距
    var labelMargin: CGFloat = 20
    
    /// 标题TitleView上面文字的大小(默认为14)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    /// 标题TitleView上面文字普通状态下的颜色(默认为黑色)
    var normalTextColor = UIColor(r: 0, g: 0, b: 0)
    
    /// 标题TitleView上面文字选中状态下的颜色(默认为橘色)
    var selectedTextColor = UIColor(r: 225, g: 127, b: 0)
    
    /// 标题TitleView上面默认选中的titleLabel的索引
    var defaultLabelIndex: Int = 0
    
    
    /**
     *  2、TitleView遮盖titleCover相关属性
     */
    
    /// 标题TitleView上面的文字是否需要遮盖(默认不需要)
    var showsTitleCover: Bool = false
    
    /// 标题TitleView上面遮盖的背景颜色(默认为灰色)
    var titleCoverBackgroundColor : UIColor = .lightGray
    
    /// 设置遮盖的透明度(透明度取值范围0~1， 默认为0.7)
    var titleCoverAlpha: CGFloat = 0.7
    
    /// 标题TitleView上面文字和遮盖之间的间隙
    var titleCoverMargin : CGFloat = 5
    
    /// 标题TitleView上面遮盖的高度
    var titleCoverHeight : CGFloat = 25
    
    /// 标题TitleView上面遮盖的宽度
    var titleCoverWidth : CGFloat = 0
    
    /// 标题TitleView上面遮盖的圆角大小
    var titleCoverRadius : CGFloat = 6
    
    
    /**
     *  3、TitleView指示器showsTitleIndicator相关属性
     */
    
    /// 是否显示titleView底部选中标题指示器(默认不显示)
    var showsTitleIndicator: Bool = false
    
    /// titleView底部选中标题指示器的宽度
    var titleIndicatorWidth : CGFloat = 15  // 10
    
    /// titleView底部选中标题指示器的高度
    var titleIndicatorHeight : CGFloat = 3  // 3
    
    /// titleView底部选中标题指示器的背景颜色
    var titleIndicatorBackgroundColor = UIColor.orange
    
    
    /**
     *  4、TitleView中标题缩放相关属性
     */
    
    /// 是否需要对TitleView上面被选中的标题进行缩放(默认不缩放)
    var needsToScale : Bool = false
    
    /// 标题TitleView上面文字缩放的范围
    var scaleRange : CGFloat = 1.1
    
    
    /**
     *  5、TitleView中分割线dividingLine相关属性
     */
    
    /// 分割线的高度
    var dividingLineHeight: CGFloat = 0.5
    
    /// 分割线的背景颜色
    var dividingLineBackgroundColor: UIColor = .lightGray
    
    
    
    
    
    
    // MARK: - 和子控制器容器ContentView相关的属性
    
    
    /// 默认选中子控制器的索引
    var defaultControllerIndex: Int = 0
    
    
    /// MARK: - TitleView和ContentView通用的属性
    
    /// 默认选中label和子控制器的索引
    var defaultIndex: Int = 0
}
