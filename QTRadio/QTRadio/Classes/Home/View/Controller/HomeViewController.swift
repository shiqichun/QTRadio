//
//  HomeViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    
    /// 顶部的searchBar
    fileprivate lazy var searchBar: UISearchBar = {
        
        // 创建searchBar
        let searchBar = UISearchBar()
        searchBar.tintColor = .lightGray
        searchBar.delegate = self
        
        return searchBar
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension HomeViewController {
    
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
        
        // 添加导航条上面的搜索框
        // FIXME: - 导航栏中间的搜索框
        
        
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
    
    
    /// 添加中间的搜索框
    private func setupSearchBar() {
        
        navigationItem.titleView = searchBar
    }
    
    
    /// 添加导航条右边的按钮
    private func setupRightBarButtonItems() {
        
        // 自定义左边的按钮
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "myHistory_30x30_"), for: .normal)
        rightBtn.setImage(UIImage(named: "myHistorypress_30x30_"), for: .highlighted)
        rightBtn.sizeToFit()
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        // 调整导航栏左边按钮与屏幕的距离
        let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightItem.width = -5
        navigationItem.rightBarButtonItems = [rightItem,UIBarButtonItem(customView: rightBtn)]
    }

    
    private func setupChildViewControllers() {
        
        // FIXME: - 从网络获取标题的Tabs，然后通过JSON来设置标题
        // 创建子控制器的标题
        let titles = ["分类", "推荐", "精品", "直播", "广播"]
        
        // 创建标题样式
        let titleStyle = TitleStyle()
        titleStyle.titleViewHeight = 44
        titleStyle.isScrollEnable = false  // 设置标题下面的指示器是否可以滚动(其实默认为不可以滚动)
        titleStyle.selectedTextColor = UIColor(r: 252, g: 89, b: 60)  // 设置选中标题的颜色
        titleStyle.scrollSlideBackgroundColor = UIColor(r: 252, g: 89, b: 60)  // 设置滚动指示器的背景颜色
        titleStyle.isShowScrollSlide = true  // 需要滚动指示器
        titleStyle.isNeedScale = false  // 需要对选中标题进行缩放
        titleStyle.titleFont = UIFont.systemFont(ofSize: 15)  // 设置子控制器标题文字大小
        titleStyle.titleBackgroundColor = UIColor(r: 234, g: 235, b: 237)  // 设置子控制器标题的背景颜色
        
        // 创建一个数组，用来存放子控制器
        var childVcs = [UIViewController]()
        
        // 创建子控制器并将其添加到childVcs数组中
        childVcs.append(CategoryViewController())  // 分类子控制器
        childVcs.append(RecommendViewController())  // 推荐子控制器
        childVcs.append(BoutiqueViewController())  // 精品子控制器
        childVcs.append(LiveViewController())  // 直播子控制器
        childVcs.append(BroadcastViewController())  // 广播子控制器
        
        // FiXME: - 为了适配iPhone X，这里高度最后还要减去一个kTabBarMargin
        // 创建containerView的frame
        // - 注意：设置containerView的高度时，一定不要忘记减去
        // - 状态栏、导航栏和tabBar的高度，否则，后面在相应控制
        // - 器的view中添加内容时，会导致有一部分内容被tabBar给
        // - 遮挡的情况出现
        let containerFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight - kTabBarMargin)
        
        // 调用自定义构造函数，根据实际需求创建合适的ContainerView对象
        let containerView = ContainerView(frame: containerFrame, titles: titles, titleStyle: titleStyle, childVcs: childVcs, parentVc: self)
        
        // 将创建好的ContainerView对象添加到当前控制器的View中
        view.addSubview(containerView)
    }
}



// MAR: - 监听导航栏上面按钮的点击
extension HomeViewController {
    
    /// 监听导航条leftBarButtonItem的点击
    @objc fileprivate func leftBarButtonItemClick() {
        
        print("HomeViewController---leftBarButtonItemClick")
    }
    
    /// 监听导航条试听历史按钮点击
    @objc fileprivate func rightBarButtonItemClick() {
        
        print("HomeViewController---rightBarButtonItemClick")
    }
}


// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
