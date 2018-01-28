//
//  QTNavigationController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class QTNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
    
    /// 重写pushViewController(_ : , animated: )方法，拦截系统的push功能
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        // 这里需要做大于0的判断，否则程序一运行tabBar就没有了
        if viewControllers.count > 0 {
            
            // push控制器的时候，隐藏tabBar
            viewController.hidesBottomBarWhenPushed = true
        }

        // 还原父类的push功能
        super.pushViewController(viewController, animated: animated)
    }

}



// MARK: - 设置UI界面
extension QTNavigationController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 
    }
}
