//
//  HomeViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 首页模块主控制器

import UIKit

class HomeViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    
    /// 用来存放子控制器
    fileprivate lazy var childVcs = [UIViewController]()
    
    /// 顶部的searchBar
    fileprivate lazy var searchBar: UISearchBar = {
        
        // 创建searchBar
        let searchBar = UISearchBar()
        searchBar.tintColor = .lightGray
//        searchBar.delegate = self
        
        return searchBar
    }()
    
    
    /// viewModel属性，用来请求网络数据
    fileprivate lazy var navBarViewModel: NavBarViewModel = NavBarViewModel()
    
    

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

        // 自定义导航栏左边的按钮
        let leftBtn = UIButton(image: "myMessage_30x30_", highlightedImage: "myMessagepress_30x30_")
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)

        // 添加导航条上面的搜索框
        // FIXME: - 导航栏中间的搜索框


        // 自定义导航栏右边的按钮
        let rightBtn = UIButton(image: "myHistory_30x30_", highlightedImage: "myHistorypress_30x30_")
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    
    /// 创建子控制器
    private func setupChildViewControllers() {
        
        // 发送网络请求，获取网络上的标题
        navBarViewModel.requestData {
            
            // 从模型中取出标题，并且将其存放到一个数组中
            let titles = self.navBarViewModel.navBarModelArray.map({ $0.title })
            
            // 对标题进行初始化设置
            let initializeSetting = InitializeSettings()
            initializeSetting.titleViewHeight = 44
            
            // 根据服务器返回的数据来设置默认选中的标题和控制器
            for (index, item) in (self.navBarViewModel.navBarModelArray.map({ $0.current })).enumerated() {
                if item {
                    
                    // 设置默认选中的标题和子控制器
                    initializeSetting.defaultIndex = index
                }
            }
            
            initializeSetting.selectedTextColor = UIColor(r: 246, g: 91, b: 90)  // 设置选中标题的颜色
            initializeSetting.titleIndicatorBackgroundColor = UIColor(r: 246, g: 91, b: 90)  // 设置滚动指示器背景颜色
            initializeSetting.showsTitleIndicator = true  // 需要滚动指示器
            initializeSetting.titleFont = UIFont.systemFont(ofSize: 15)  // 设置子控制器标题文字大小
            initializeSetting.titleBackgroundColor = UIColor(r: 246, g: 246, b: 246)  // 设置子控制器标题的背景颜色
            
            
            // 创建子控制器并将其添加到childVcs数组中
            self.childVcs.append(CategoryViewController())  // 分类子控制器
            self.childVcs.append(RecommendViewController())  // 推荐子控制器
            self.childVcs.append(BoutiqueViewController())  // 精品子控制器
            self.childVcs.append(LiveViewController())  // 直播子控制器
            self.childVcs.append(BroadcastViewController())  // 广播子控制器
            
            
            // FiXME: - 为了适配iPhone X，这里高度最后还要减去一个kTabBarMargin
            // 创建containerView的frame
            // - 注意：设置containerView的高度时，一定不要忘记减去
            // - 状态栏、导航栏和tabBar的高度，否则，后面在相应控制
            // - 器的view中添加内容时，会导致有一部分内容被tabBar给
            // - 遮挡的情况出现
            let containerFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight - kTabBarMargin)
            
            // 调用自定义构造函数，根据实际需求创建合适的ContainerView对象
            let containerView = ContainerView(frame: containerFrame, titles: titles, initializeSetting: initializeSetting, childViewControllers: self.childVcs, parentViewController: self)
            
            // 将创建好的ContainerView对象添加到当前控制器的View中
            self.view.addSubview(containerView)
        }
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
//extension HomeViewController: UISearchBarDelegate {
//
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
//}

