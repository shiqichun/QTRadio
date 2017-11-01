//
//  ContainerView.swift
//  ContainerView
//
//  Created by Enrica on 2017/8/30.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


// MARK: - 重要的属性和方法

class ContainerView: UIView {

    // MARK: - 私有属性
    
    /// 保存从外部控制器传递过来的标题titles
    fileprivate var titles: [String]
    
    /// 保存从外部控制器传递过来的标题样式titleStyle
    fileprivate var titleStyle: TitleStyle
    
    /// 保存从外部控制器传递过来的子控制器childVcs
    fileprivate var childVcs: [UIViewController]
    
    /// 保存从外部控制器传递过来的父控制器parentVc
    fileprivate var parentVc: UIViewController
    
    
    /// 保存创建出来的titleView和contentView，以方便后面使用
    fileprivate var titleView: TitleView!
    fileprivate var contentView: ContentView!
    
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String], titleStyle: TitleStyle, childVcs: [UIViewController], parentVc: UIViewController) {
        
        // 初始化私有属性(给私有属性赋值)
        self.titles = titles
        self.titleStyle = titleStyle
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        // 调用父类的构造函数
        super.init(frame: frame)
        
        // 适配iPhone X
        if #available(iOS 7.0, *) {
            parentVc.automaticallyAdjustsScrollViewInsets = false
        }
        
        // 设置UI界面(在containerView上面添加titleView和contentView)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}




/**
 *  下面的代码主要是负责UI界面的设置
 */
// MARK: - 设置UI界面
extension ContainerView {
    
    /// 添加titleView和contentView
    fileprivate func setupUI() {
        
        // 添加titleView
        setupTitleView()
        
        // 添加contentView
        setupContentView()
    }
    
    /// 创建titleView
    private func setupTitleView() {
        
        // 设置titleView的frame
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: titleStyle.titleViewHeight)
        
        // 根据从外部控制器传递过来的标题titles，以及标题样式titleStyle创建自定义的titleView
        titleView = TitleView(frame: titleFrame, titles: titles, titleStyle: titleStyle)
        
        // 将titleView添加到当前控件containerView上
        addSubview(titleView)
        
        
        
        /******** 让ContainerView成为titleView的代理 ********/
        titleView.delegate = self
    }
    
    
    /// 创建contentView
    private func setupContentView() {
        
        // 设置contentView的frame
        let contentFrame = CGRect(x: 0, y: titleStyle.titleViewHeight, width: bounds.width, height: bounds.height - titleStyle.titleViewHeight)
        
        // 根据从外部控制器传递过来的子控制器和父控制器，创建自定义的contentView
        contentView = ContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc)
        
        // 将contentView添加到当前控件containerView中
        addSubview(contentView)
        
        
        
        /******** 让ContainerView成为contentView的代理 ********/
        contentView.delegate = self
    }
}





/**
 *  下面的代码主要是负责实现TitleViewDelegate代理协议中的方法，
 *  将从titleView中传递过来的当前titleLabel的下标传递给contentView
 */
// MARK: - TitleViewDelegate
extension ContainerView: TitleViewDelegate {
    
    /// 实现TitleViewDelegate中的代理方法
    func titleView(_ titleView: TitleView, selectedTitleLabelIndex titleIndex: Int) {
        
        // 通过ContentView中对外暴露的方法，接收从TitleView中传递过来的titleLabel下标值
        contentView.getSelectedTitleLabelIndex(titleIndex)
    }
}





/**
 *  下面的代码主要是负责实现ContentViewDelegate代理协议中的方法，
 *  将从contentView中传递过来的当前子控制器的下标传递给titleView
 */
// MARK: - ContentViewDelegate
extension ContainerView: ContentViewDelegate {
    
    /// 实现ContentViewDelegate中的代理方法，接收从里面传递过来的当前子控制器的下标
    func contentView(_ contentView: ContentView, selectedChildVcIndex childVcIndex: Int) {
        
        // 将当前子控制器的下标通过TitleView中对外暴露的方法传递给TitleView
        titleView.getSelectedChildVcIndex(childVcIndex)
    }
}
