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
        
        // 调整导航栏左边按钮与屏幕的距离
        //        let leftItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        //        leftItem.width = -5
        //        navigationItem.leftBarButtonItems = [leftItem,UIBarButtonItem(customView: leftBtn)]
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
        
        // 调整导航栏左边按钮与屏幕的距离
        let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightItem.width = -5
        navigationItem.rightBarButtonItems = [rightItem,UIBarButtonItem(customView: rightBtn)]
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

