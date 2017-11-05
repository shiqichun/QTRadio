//
//  DailyViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 点击推荐专辑，或者更多推荐之后跳转的控制器

import UIKit
import Kingfisher


/// cell可重用标识符
private let kTableViewCellIdentifier = "tableViewCellIdentifier"

class DailyViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    
    /// tableView控件属性
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        
        tableView.backgroundColor = UIColor(r: 190, g: 158, b: 105)
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        // 临时调整tableView的高度
        tableView.rowHeight = 300
        
        tableView.register(DailyViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        return tableView
    }()
    
    
    /// 用于请求网络数据的ViewModel属性
    fileprivate lazy var dailyViewModel: DailyViewModel = DailyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
    
    
    

}



// MARK: - 设置UI界面
extension DailyViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加tableView
        view.addSubview(tableView)
        
        // 设置tableView的contentInset
        tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        
        // 自动计算tableViewCell的高度
        //self.tableView.estimatedRowHeight = 100.0
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        // 请求网路数据
        loadData()
    }
}



// MARK: - 请求网络数据
extension DailyViewController {
    
    /// 请求网络数据
    fileprivate func loadData() {
        
        // 请求网路数据
        dailyViewModel.requestData {
            
            // 重新调用数据源方法
            self.tableView.reloadData()
        }
    }
}




// MARK: - UITableViewDataSource
extension DailyViewController: UITableViewDataSource {
    
    // 返回分组中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyViewModel.dailyArr.count
    }
    
    // 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 根据可重用标识符取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier) as! DailyViewCell
        
        // 取出模型
        let daily = dailyViewModel.dailyArr[indexPath.row]
        
        // 顶部标题
        cell.topTitle.text = daily.title
        
        // 主标题
        cell.titleLabel.text = daily.channel_title
        
        // 配图
        let url = URL(string: daily.img_url)
        cell.myImageView.kf.setImage(with: url)
        
        // 分类
        cell.categoryName.text = daily.category_name
        
        // 播放次数
        cell.playCountLabel.text = daily.playcount
        
        // 正文
        cell.myTextLabel.text = daily.desc
        
        return cell
    }
}



// MARK: - UITableViewDelegate
extension DailyViewController: UITableViewDelegate {
    
    //
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
}
