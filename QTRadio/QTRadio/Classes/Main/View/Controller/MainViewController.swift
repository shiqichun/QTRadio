//
//  MainViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// MainViewController用来管理所有的tabBar子控制器

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension MainViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加所有的tabBar子控制器
        addChildViewControllers()
        
        
        // 中间发布按钮的背景View的frame
        let backgroundFrame = CGRect(x: 0, y: 0, width: kPlayButtonViewWidth, height: kPlayButtonViewHeight)
        
        // 自定义tabBar，中间按钮的尺寸最好是由外界决定，并且
        // 最好是要把控制器本身传递过去，否则后面就没办法modal
        let tabBar = QTTabBar(frame: self.tabBar.frame, backgroundFrame: backgroundFrame, parentVc: self)
        setValue(tabBar, forKeyPath: "tabBar")
    }
    
    /// 添加所有的tabBar子控制器
    private func addChildViewControllers() {
        
        // 分别添加tabBar的子控制器
        addChildViewController(HomeViewController(), imageName: "minibar_home", title: "首页")
        addChildViewController(FavoriteViewController(), imageName: "minibar_myfavorite", title: "收藏")
        addChildViewController(DownloadViewController(), imageName: "minibar_download", title: "下载")
        addChildViewController(ProfileViewController(), imageName: "minibar_usercenter", title: "我的")
    }
    
    /// 添加单个tabBar子控制器
    private func addChildViewController(_ childController: UIViewController, imageName: String, title: String = "") {
        
        // 设置tabBar子控制器的标题
        childController.title = title
        
        // 设置tabBarItem的背景图片(minibar_home_normal_30x30_)
        childController.tabBarItem.image = UIImage(named: imageName + "_normal_30x30_")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlight_30x30_")?.withRenderingMode(.alwaysOriginal)
        
        // 调整tabBarItem图片的位置
        // childController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        // 将子控制器包装秤导航控制器
        let nav = UINavigationController(rootViewController: childController)
        
        // 将导航控制器添加到父控制器中
        addChildViewController(nav)
    }
}
