//
//  MainViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

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
        
        // 将子控制器包装秤导航控制器
        let nav = UINavigationController(rootViewController: childController)
        
        // 将导航控制器添加到父控制器中
        addChildViewController(nav)
    }
}
