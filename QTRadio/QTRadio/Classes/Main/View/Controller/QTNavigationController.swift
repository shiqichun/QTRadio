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

}



// MARK: - 设置UI界面
extension QTNavigationController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
    }
    
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条左边的按钮
        setupLeftBarButtonItem()
        
        // 添加导航条上面的搜索框
        // FIXME: - 导航栏中间的搜索框
        
        
        // 添加导航条右边的按钮
        setupRightBarButtonItem()
    }
    
    /// 添加导航条左边的按钮
    private func setupLeftBarButtonItem() {
        
        // 自定义左边的按钮
        let leftBtn = UIButton(image: "myMessage_30x30_", highlightedImage: "myMessagepress_30x30_")
        
//        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    
    // FIXME: - 中间搜索框的代码有待完善
    /// 添加中间的搜索框
//    private func setupSearchBar() {
//
//        navigationItem.titleView = searchBar
//    }
    
    
    /// 添加导航条右边的按钮
    private func setupRightBarButtonItem() {
        
        // 自定义右边的按钮
        let rightBtn = UIButton(image: "myHistory_30x30_", highlightedImage: "myHistorypress_30x30_")
        
//        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
}
