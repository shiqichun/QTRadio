//
//  TitleStyle.swift
//  ContainerView
//
//  Created by Enrica on 2017/8/30.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class TitleStyle {
    
    
    // MARK: - 标题TitleView相关属性

    
    /// 设置标题的背景颜色(默认为白色)
    /// - 因为标题不是直接添加到titleView上面，而
    /// - 是添加到titleLabel上面，而titleLabel
    /// - 又是添加到titleScrollView上面的。因此
    /// - 如果想修改标题的背景颜色，就需要同时修改
    /// - titleScrollView和titleLabel的背景颜色
    var titleBackgroundColor = UIColor.white
    
    /// 标题TitleView的高度(如果外界不传，默认为44)
    var titleViewHeight: CGFloat = 44
    
    /// 标题TitleView是否可以滚动(默认为不可以滚动)
    var isScrollEnable: Bool = false
    
    /// 标题TitleView可以滚动时，titleLabel之间的间距
    var titleMargin: CGFloat = 20
    
    /// 标题TitleView上面文字的大小(默认为14)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    /// 标题TitleView上面文字普通状态下的颜色(默认为黑色)
    var normalTextColor = UIColor(r: 0, g: 0, b: 0)
    
    /// 标题TitleView上面文字选中状态下的颜色(默认为橘色)
    var selectedTextColor = UIColor(r: 225, g: 127, b: 0)
    
    
    
    
    
    // MARK: - 遮盖coverView相关属性
    
    
    /// 标题TitleView上面的文字是否需要遮盖(默认不需要)
    var isShowCoverView: Bool = false
    
    /// 标题TitleView上面遮盖的背景颜色(默认为灰色)
    var coverViewBackgroundColor : UIColor = .lightGray
    
    /// 设置遮盖的透明度(透明度取值范围0~1， 默认为0.7)
    var coverViewAlpha: CGFloat = 0.7
    
    /// 标题TitleView上面文字和遮盖之间的间隙
    var coverViewMargin : CGFloat = 5
    
    /// 标题TitleView上面遮盖的高度
    var coverViewHeight : CGFloat = 25
    
    /// 标题TitleView上面遮盖的宽度
    var coverViewWidth : CGFloat = 0
    
    /// 标题TitleView上面遮盖的圆角大小
    var coverViewRadius : CGFloat = 6
    
    
    
    
    
    
    // MARK: - 指示器scrollSlide相关属性
    
    
    /// 是否显示TitleView底部滚动指示器(默认不显示)
    var isShowScrollSlide: Bool = false
    
    /// 标题TitleView底部滚动条的高度
    var scrollSlideHeight : CGFloat = 2
    
    /// 标题TitleView底部指示器的背景颜色
    var scrollSlideBackgroundColor = UIColor(r: 225, g: 127, b: 0)
    
    
    
    
    
    
    // MARK: - 标题缩放相关属性
    
    
    /// 是否需要对TitleView上面被选中的标题进行缩放(默认不缩放)
    var isNeedScale : Bool = false
    
    /// 标题TitleView上面文字缩放的范围
    var scaleRange : CGFloat = 1.2
    
    
    

    
    // MARK: - 分割线dividingLine相关属性
    
    
    /// 分割线的高度
    var dividingLineHeight: CGFloat = 0.5
    
    /// 分割线的背景颜色
    var dividingLineBackgroundColor: UIColor = .lightGray
}
