//
//  ProfileViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 我的模块主控制器

import UIKit

/// 通用间距
private let kMargin: CGFloat = 5

/// 可重用标识符
private let kTableViewCellIdentifier = "kTableViewCellIdentifier"

/// ProfileHeader的高度
private let kProfileHeaderHeight: CGFloat = kScreenHeight * 0.3  // iPhone X中是162.4

class ProfileViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// 修改导航栏中间的标题
    fileprivate lazy var label: UILabel = {
        
        let label = UILabel()
        label.text = "我的"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        // 创建tableView
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        // 调整tableView默认的组间距
        tableView.sectionHeaderHeight = kMargin
        tableView.sectionFooterHeight = kMargin
        
        // 设置tableView岁父控件一起拉伸
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        tableView.dataSource = self
        
        // 设置tableView的代理
        tableView.delegate = self
        
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        return tableView
    }()
    
    
    /// 顶部的ProfileHeader
    fileprivate lazy var profileHeader: ProfileHeader = {
        
        let profileHeader = ProfileHeader(frame: CGRect(x: 0, y: -kProfileHeaderHeight, width: kScreenWidth, height: kProfileHeaderHeight))
        return profileHeader
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension ProfileViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加tableView
        view.addSubview(tableView)
        
        // 设置tableView的contentInset
        tableView.contentInset = UIEdgeInsets(top: kProfileHeaderHeight, left: 0, bottom: 0, right: 0)
        
        // 添加ProfileHeader。因为它是要随着tableView一起滚动的，所以
        // 不能直接将其添加到控制器的view上面，而是应该添加到tableView上
        tableView.addSubview(profileHeader)
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 自定义导航栏左边的按钮
        let leftBtn = UIButton(image: "myMessage_30x30_", highlightedImage: "myMessagepress_30x30_")
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 自定义导航栏右边的按钮
        let rightBtn = UIButton(image: "searchInNavigation_30x30_", highlightedImage: "searchInNavigationpress_30x30_")
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
}





// MAR: - 监听导航栏上面按钮的点击
extension ProfileViewController {
    
    /// 监听导航条leftBarButtonItem的点击
    @objc fileprivate func leftBarButtonItemClick() {
        
        print("ProfileViewController---leftBarButtonItemClick")
    }
    
    /// 监听导航条试听历史按钮点击
    @objc fileprivate func rightBarButtonItemClick() {
        
        print("ProfileViewController---rightBarButtonItemClick")
    }
}




// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    // 返回cell的分组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    // 返回每一组的cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return 3
        case 2:
            return 2
        case 5:
            return 4
        default:
            return 1
        }
    }
    
    // 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 根据可重用标识符出去cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier)
        
        cell?.textLabel?.text = "cell---\(indexPath.row)"
        
        return cell!
    }
    
}



// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    // 设置tableView的header的高度。当使用grouped样式时，
    // 将header的高度设置为极小值，可以去掉顶部巨大的留白
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return CGFloat.leastNormalMagnitude  // 相当于之前的CGFloat.min
    }
    
}

