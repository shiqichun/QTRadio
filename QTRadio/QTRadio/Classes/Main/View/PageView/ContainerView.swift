//
//  ContainerView.swift
//  PageView
//
//  Created by Enrica on 2018/1/4.
//  Copyright © 2018年 Enrica. All rights reserved.
//
// ContainerView类管理两个重要的控件，即用于容纳子控制器的控件ContentView
// 对象，以及用于容纳子控制器标题的控件TitleView对象

import UIKit

class ContainerView: UIView {

    // MARK: - 私有属性
    
    /// 用于保存外部控制器传递过来的标题
    fileprivate var titles: [String]
    
    /// 用于保存外部控制器传递过来的默认设置
    fileprivate var initializeSetting: InitializeSettings
    
    /// 用于保存外部控制器传递过来的子控制器
    fileprivate var childViewControllers: [UIViewController]
    
    /// 用于保存外部控制器传递过来的父控制器
    fileprivate var parentViewController: UIViewController
    
    
    // MARK: - 保存创建的TitleView和ContentView对象，以供后续使用
    fileprivate var titleView: TitleView!
    fileprivate var contentView: ContentView!
    
    
    // MARK: - 自定义构造函数
    
    /// 用于创建容器containerView
    /// - 参数frame：表示容器控件containerView的frame
    /// - 参数titles：表示所有子控制器的标题
    /// - 参数initializeSetting：表示子控制器及其标题的默认初始化设置
    /// - 参数childViewControllers：表示所有的子控制器
    /// - 参数parentViewController：表示父控制器
    init(frame: CGRect, titles: [String], initializeSetting: InitializeSettings, childViewControllers: [UIViewController], parentViewController: UIViewController) {
        
        // 初始化私有属性(将外部传递过来的参数值保存起来)
        self.titles = titles
        self.initializeSetting = initializeSetting
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        
        // 初始化父类的私有属性
        super.init(frame: frame)
        
        // FIXME: - 适配iPhone X
        if #available(iOS 7.0, *) {
            parentViewController.automaticallyAdjustsScrollViewInsets = false
        }
        
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - 设置UI界面
extension ContainerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加titleView
        setupTitleView()
        
        // 添加contentView
        setupContentView()
    }
    
    /// 用于创建容纳子控制器标题的控件titleView
    private func setupTitleView() {
        
        // 创建titleView的frame
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: initializeSetting.titleViewHeight)
        
        // 根据参数titleFrame、titles和initializeSetting来创建TitleView对象，并且将其保存起来
        titleView = TitleView(frame: titleFrame, titles: titles, initializeSetting: initializeSetting)
        
        // 将titleView添加到当前控件containerView中
        addSubview(titleView)
        
        // 让ContainerView成为titleView的代理，接收从titleView中传递过来的被选中label的索引
        titleView.delegate = self
    }
    
    /// 用于创建容纳子控制器的控件contentView
    private func setupContentView() {
        
        // 创建contentView的frame
        let contentFrame = CGRect(x: 0, y: initializeSetting.titleViewHeight, width: bounds.width, height: bounds.height - initializeSetting.titleViewHeight)
        
        // 根据参数外界传递进来的参数创建ContentView对象，并且将其保存起来
        contentView = ContentView(frame: contentFrame, initializeSetting: initializeSetting, childViewControllers: childViewControllers, parentViewController: parentViewController)
        
        // 将contentView添加到当前控件containerView中
        addSubview(contentView)
        
        // 让ContainerView成为contentView的代理，接收从contentView中传递过来的被选中控制器的索引
        contentView.delegate = self
    }
}



// MARK: - TitleViewDelegate
extension ContainerView: TitleViewDelegate {
    
    /// 实现TitleViewDelegate中的代理方法，通知contentView中的子控制器调整到正确的位置
    func titleView(_ titleView: TitleView, selectedLabelIndex index: Int) {
        
        // 通过ContentView中对外暴露的方法，将从titleView中传递过来的下标值传递给contentView
        contentView.scrollController(toIndex: index)
    }
}



// MARK: - ContentViewDelegate
extension ContainerView: ContentViewDelegate {
    
    /// 实现ContentViewDelegate协议的代理方法，通知titleView中的label调整到正确的位置
    func contentView(_ contentView: ContentView, selectedControllerIndex: Int) {
        
        // 通过TitleView中对外暴露的方法，将从contentView中传递过来的下标值传递给titleView
        titleView.scrollLabel(toIndex: selectedControllerIndex)
    }
}

