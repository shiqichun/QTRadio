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
        
        // 注册cell(因为要选择cell的样式，所以这里不太适合用注册的方式创建cell)
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        return tableView
    }()
    
    
    /// 顶部的ProfileHeader
    fileprivate lazy var profileHeader: ProfileHeader = {
        
        let profileHeader = ProfileHeader(frame: CGRect(x: 0, y: -kProfileHeaderHeight, width: kScreenWidth, height: kProfileHeaderHeight), parentVc: self)
        return profileHeader
    }()
    
    /// 数组属性，用于存储组模型数组
    fileprivate lazy var groupArr = [[ProfileCellModel]]()
    
    

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
        
        // 给cell创建模型数据
        setupProfileCellData()
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
    
    
    /// 创建Profile界面中的cell的模型数据
    private func setupProfileCellData() {
        
        // 创建cell模型
        DispatchQueue.global().async {
            
            // MARK: - 第一组cell
            
            // 创建消息中心模型
            let msgCell = ProfileCellModel(cellImageName: "mine_msg_24x24_", cellTitle: "消息中心")
            // 创建一个模型数组group0
            var group0 = [ProfileCellModel]()
            // 将模型存放在数组中
            group0.append(msgCell)
            // 将模型数组group0存放在数组groupArr中
            self.groupArr.append(group0)
            
            
            // MARK: - 第二组cell
            
            
            // 创建我的余额模型
            let balanceCell = ProfileCellModel(cellImageName: "mine_balance_24x24_", cellTitle: "我的余额", cellSubtitle: "登陆后可同步")
            // 创建已购项目模型
            let payCell = ProfileCellModel(cellImageName: "mine_pay_24x24_", cellTitle: "已购项目", cellSubtitle: "登陆后可同步")
            // 创建我的优惠券模型
            let ticketCell = ProfileCellModel(cellImageName: "mine_ticket_24x24_", cellTitle: "我的优惠券", cellSubtitle: "登陆后可同步")
            // 创建模型数组group1
            var group1 = [ProfileCellModel]()
            // 将模型存放在模型数组中
            group1.append(balanceCell)
            group1.append(payCell)
            group1.append(ticketCell)
            // 将模型数组group1存放到数组groupArr中
            self.groupArr.append(group1)
            
            
            // MARK: - 第三组cell
            
            
            // 创建蜻蜓商城模型
            let yzhCell = ProfileCellModel(cellImageName: "mine_yzh_24x24_", cellTitle: "蜻蜓商城")
            // 创建9块9包邮模型
            let wemartCell = ProfileCellModel(cellImageName: "mine_wemart_24x24_", cellTitle: "9块9包邮", cellSubtitle: "9块9包邮")
            // 创建模型数组group2
            var group2 = [ProfileCellModel]()
            // 将模型存放到模型数组中
            group2.append(yzhCell)
            group2.append(wemartCell)
            // 将模型数组group2存放到数组groupArr中
            self.groupArr.append(group2)
            
            
            // MARK: - 第四组cell
            
            
            // 创建我的会员模型
            let memberCell = ProfileCellModel(cellImageName: "me_member_20x20_", cellTitle: "我的会员")
            // 创建模型数组group3
            var group3 = [ProfileCellModel]()
            // 将模型存放到模型数组group3中
            group3.append(memberCell)
            // 将模型数组group3存放到数组groupArr中
            self.groupArr.append(group3)
            
            
            // MARK: - 第五组cell
            
            
            // 创建游戏中心模型
            let gamecenterCell = ProfileCellModel(cellImageName: "mine_gamecenter_24x24_", cellTitle: "游戏中心", cellSubtitle: "人本艰，一场游戏一场梦")
            // 创建模型数组group4
            var group4 = [ProfileCellModel]()
            // 将模型存放到模型数组group4中
            group4.append(gamecenterCell)
            // 将模型数组group4存放到数组groupArr中
            self.groupArr.append(group4)
            
            
            // MARK: - 第六组cell
            
            
            // 创建夜间模式模型
            let nightModeCell = ProfileCellModel(cellImageName: "mine_nightMode_24x24_", cellTitle: "夜间模式")
            // 创建定时关闭模型
            let timerCell = ProfileCellModel(cellImageName: "mine_timer_24x24_", cellTitle: "定时关闭")
            // 创建闹钟模型
            let clockCell = ProfileCellModel(cellImageName: "mine_clock_24x24_", cellTitle: "闹钟")
            // 创建预约模型
            let subscribeCell = ProfileCellModel(cellImageName: "mine_subscribe_24x24_", cellTitle: "预约")
            // 创建模型数组group5
            var group5 = [ProfileCellModel]()
            // 将模型存放到模型数组group5中
            group5.append(nightModeCell)
            group5.append(timerCell)
            group5.append(clockCell)
            group5.append(subscribeCell)
            // 将模型数组group5存放到数组groupArr中
            self.groupArr.append(group5)
            
            
            // MARK: - 第七组cell
            
            
            // 创建设置模型
            let settingCell = ProfileCellModel(cellImageName: "mine_setting_24x24_", cellTitle: "设置")
            // 创建模型数组group6
            var group6 = [ProfileCellModel]()
            // 将设置模型存放到模型数组group6中
            group6.append(settingCell)
            // 将模型数组group6存放到数组groupArr中
            self.groupArr.append(group6)
            
        }
        
        // 刷新表格
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

        // 返回分组数
        return groupArr.count
    }
    
    // 返回每一组的cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // 返回每一组中cell的数量
        return groupArr[section].count
        
    }
    
    // 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 根据可重用标识符出去cell
        var cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier)
        
        // 如果没有可重用的cell，则创建cell
        if cell == nil {
            
            // 创建cell的样式
            cell = UITableViewCell(style: .value1, reuseIdentifier: kTableViewCellIdentifier)
        }
        
        // 取出存放cell的数组
        let cellArr = groupArr[indexPath.section]
        
        // 从数组中取出cell
        let item = cellArr[indexPath.row]
        
        // 设置cell的配图
        cell?.imageView?.image = UIImage(named: item.cellImageName)
        
        // 设置cell的主标题
        cell?.textLabel?.text = item.cellTitle
        
        // 设置cell的副标题
        cell?.detailTextLabel?.text = item.cellSubtitle
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        // 设置cell右边箭头
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
}



// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    // 设置tableView的header的高度。当使用grouped样式时，
    // 将header的高度设置为极小值，可以去掉顶部巨大的留白
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        // 相当于之前的CGFloat.min
        return CGFloat.leastNormalMagnitude
    }
    
}

