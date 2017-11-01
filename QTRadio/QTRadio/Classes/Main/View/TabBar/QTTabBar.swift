//
//  QTTabBar.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 自定义TabBar
// 另外，在Swift中有命名空间的概念，其实是不需要写类前缀的，但是这里为了好看
// 加上了项目的类前缀。如果不加，以后再新建类时，也不会产生类名冲突。OC没有命
// 名空间，所以如果是写OC代码的话，为了防止后续冲突，是需要写类前缀的

import UIKit

class QTTabBar: UITabBar {

    // MARK: - 私有属性
    
    /// 中间发布按钮背景View的frame
    fileprivate var backgroundFrame: CGRect
    
    /// 保存父控制器
    fileprivate var parentVc: UIViewController
    
    
    
    // MARK: - 懒加载属性
    
    /// 中间播放按钮的背景view
    fileprivate lazy var playButtonView: PlayButtonView = {
        
        // FIXME: - 这里稍后需要检查一下有没有循环引用
        
        // 创建中间播放按钮的playButtonView
        let playButtonView = PlayButtonView(frame: self.backgroundFrame, parentVc: self.parentVc)
        
        return playButtonView
    }()
    
    
    
    // MARK: - 自定义构造函数
    
    /// 根据实际需要创建合适的tabBar
    /// - 参数frame: 表示tabBar的frame
    /// - 参数backgroundFrame: 表示tabBar中间背景View的frame
    /// - 参数parentVc: 表示父控制器
    init(frame: CGRect, backgroundFrame: CGRect, parentVc: UIViewController) {
        
        // 将从外部控制器传递过来的数据保存到私有属性中
        self.backgroundFrame = backgroundFrame
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        // 统一设置tabBar的UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension QTTabBar {
    
    /// 统一设置tabBar的UI界面
    fileprivate func setupUI() {
        
        // 设置tabBar的背景图片(因为要适配iPhone X，没有找到对应的背景图片，所以就不设置了)
        if #available(iOS 11, *) {
            // 找不到合适的背景图片，就设置背景颜色
            barTintColor = UIColor(r: 255, g: 255, b: 255)
        } else {
            // 设置背景图片
            backgroundImage = UIImage(named: "tabbar_bg")
        }
        
        // 将播放按钮的背景控件添加到tabBar上面
        addSubview(playButtonView)
    }
    
    
    
    
    
    /// 调整tabBarItem的位置，并且布局中间的播放按钮
    override func layoutSubviews() {
        super.layoutSubviews()

        // 用于存储tabBarButton按钮
        // 这个数组最好是放在这里，不要
        // 放在懒加载代码中。因为layoutSubviews
        // 有一些很重要的工作要做，
        var tabBarButtonArr = [Any]()

        // 遍历tabBar的子控件
        for subView in self.subviews {

            // 将所有UITabBarButton存放到数组中
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                tabBarButtonArr.append(subView)
            }
        }

        // 获取tabBar的宽度和高度
        let tabBarWidth: CGFloat = self.bounds.size.width

        // 获取playButtonView的宽度
        let playButtonViewWidth: CGFloat = playButtonView.frame.width

        // 计算tabBarButton的宽度(tabBar的宽度 - playButtonView的宽度 / tabBarButton的个数, tabBarButton = 4)
        let tabBarButtonWidth: CGFloat = (tabBarWidth - playButtonViewWidth) / CGFloat(tabBarButtonArr.count)

        // 遍历tabBarButtonArr，取出里面的tabBarButton和与之对应的index
        for (index, subview) in tabBarButtonArr.enumerated() {

            // 取出subview的frame
            var subviewFrame = (subview as! UIView).frame

            if index >= tabBarButtonArr.count / 2 {

                // 设置下标为2和3的tabBarButton的x值
                subviewFrame.origin.x = CGFloat(index) * tabBarButtonWidth + playButtonViewWidth
            } else {

                // 设置下标为0和1的tabBarButton的x值
                subviewFrame.origin.x = CGFloat(index) * tabBarButtonWidth
            }

            // 设置tabBarButton的宽度
            subviewFrame.size.width = tabBarButtonWidth

            // 重写设置tabBarButton的frame
            (subview as! UIView).frame = subviewFrame
        }

        // 将播放按钮移动到最上面
        bringSubview(toFront: playButtonView)
        
        
        // 重新布局playButtonView的位置
        playButtonView.frame.origin.x = 2 * tabBarButtonWidth
        playButtonView.frame.origin.y = kTabBarHeight - kPlayButtonViewHeight  + 5
    }

    
    
    
    /// 重写hitTest(_ : , with : )方法，让超出tabBar部分也能响应事件
    /// - 如果父控件不能接收触摸事件，那么子控件就不可能接收触摸事件
    /// - 返回的是谁，谁就是最适合处理事件的View
    /// - hitTest(_ : , with : )方法会被调用两次
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        // 调用父控件的hitTest(_ : , with : )方法
        var result = super.hitTest(point, with: event)

        // 如果控件不可交互、控件被隐藏，或者控件是透明的，则表示不能处理事件(控件不交互的三种情况)
        if self.isUserInteractionEnabled == false || self.isHidden == true || self.alpha <= 0.01 {
            return nil
        }

        // 当result可以处理事件时，返回result
        if (result != nil) { return result }

        // 遍历tabBar的子控件
        for subview in subviews {

            // 把这个坐标从tabBar的坐标系转为postButton的坐标系
            let subPoint: CGPoint = subview.convert(point, from: self)

            // 调用子控件，也就是postButton的hitTest(_ : , with : )方法
            result = subview.hitTest(subPoint, with: event)

            // 如果事件发生在subview里就返回result
            if (result != nil) {
                return result
            }
        }

        return nil
    }
}
