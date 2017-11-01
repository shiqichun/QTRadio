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
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条左边的按钮
        setupLeftBarButtonItem()
        
        // 添加导航条上面的搜索框
//        setupSearchBar()
        
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
        
        // 调整导航栏左边按钮与屏幕的距离
//        let leftItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        leftItem.width = -5
//        navigationItem.leftBarButtonItems = [leftItem,UIBarButtonItem(customView: leftBtn)]
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
