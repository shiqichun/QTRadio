//
//  BroadcastViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中广播子控制器

// 广播剧
// http://api2.qingting.fm/v6/media/recommends/guides/section/206?device_id=093e8b7e24c02246fe92373727e4a92c

import UIKit

// 可重用标识符
private let kTableViewCellIdentifier = "kTableViewCellIdentifier"



class BroadcastViewController: UIViewController {

    // MARK: - 懒加载属性
    
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        // 创建tableView
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        // 调整tableView默认的组间距
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 0
        
        // 设置tableView岁父控件一起拉伸
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        tableView.dataSource = self

        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension BroadcastViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加tableView
        view.addSubview(tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 10, right: 0)
    }
}




// MARK: - UITableViewDataSource
extension BroadcastViewController: UITableViewDataSource {
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier)
        
        cell?.textLabel?.text = "cell---\(indexPath.row)"
        
        return cell!
    }
    
}
