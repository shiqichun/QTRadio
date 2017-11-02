//
//  DownloadViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// 修改导航栏中间的标题
    fileprivate lazy var label: UILabel = {
        
        let label = UILabel()
        label.text = "我的下载"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension DownloadViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
        
        
        // 添加首页子控制器
        setupChildViewControllers()
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条左边的按钮
        setupLeftBarButtonItem()
        
        // 修改导航栏中间的标题
        navigationItem.titleView = label
        
        // 添加导航条右边的按钮
        setupRightBarButtonItems()
    }
    
    /// 添加导航条左边的按钮
    private func setupLeftBarButtonItem() {
        
        // 自定义左边的按钮
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "myMessage_30x30_"), for: .normal)
        leftBtn.setImage(UIImage(named: "myMessagepress_30x30_"), for: .highlighted)
        leftBtn.sizeToFit()
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    
    /// 添加导航条右边的按钮
    private func setupRightBarButtonItems() {
        
        // 自定义左边的按钮
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "searchInNavigation_30x30_"), for: .normal)
        rightBtn.setImage(UIImage(named: "searchInNavigationpress_30x30_"), for: .highlighted)
        rightBtn.sizeToFit()
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    
    
    private func setupChildViewControllers() {
        
        // FIXME: - 从网络获取标题的Tabs，然后通过JSON来设置标题
        // 创建子控制器的标题
        let titles = ["已经下载", "正在下载"]
        
        // 创建标题样式
        let titleStyle = TitleStyle()
        titleStyle.titleViewHeight = 44
        titleStyle.isScrollEnable = false  // 设置标题下面的指示器是否可以滚动(其实默认为不可以滚动)
        titleStyle.normalTextColor = .lightGray
        titleStyle.selectedTextColor = UIColor(r: 246, g: 91, b: 90)  // 设置选中标题的颜色
        titleStyle.scrollSlideBackgroundColor = UIColor(r: 246, g: 91, b: 90)  // 设置滚动指示器的背景颜色
        titleStyle.isShowScrollSlide = true  // 需要滚动指示器
        titleStyle.isNeedScale = false  // 需要对选中标题进行缩放
        titleStyle.titleFont = UIFont.systemFont(ofSize: 15)  // 设置子控制器标题文字大小
        
        // 创建一个数组，用来存放子控制器
        var childVcs = [UIViewController]()
        
        // 创建子控制器并将其添加到childVcs数组中
        childVcs.append(DownloadedViewController())  // 已下载
        childVcs.append(DownloadingViewController())  // 正在下载
        
        let containerFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight - kTabBarMargin)
        
        // 调用自定义构造函数，根据实际需求创建合适的ContainerView对象
        let containerView = ContainerView(frame: containerFrame, titles: titles, titleStyle: titleStyle, childVcs: childVcs, parentVc: self)
        
        // 将创建好的ContainerView对象添加到当前控制器的View中
        view.addSubview(containerView)
    }
    
}





// MAR: - 监听导航栏上面按钮的点击
extension DownloadViewController {
    
    /// 监听导航条leftBarButtonItem的点击
    @objc fileprivate func leftBarButtonItemClick() {
        
        print("DownloadViewController---leftBarButtonItemClick")
    }
    
    /// 监听导航条试听历史按钮点击
    @objc fileprivate func rightBarButtonItemClick() {
        
        print("DownloadViewController---rightBarButtonItemClick")
    }
}

