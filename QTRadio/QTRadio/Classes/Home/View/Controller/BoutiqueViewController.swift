//
//  BoutiqueViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中精品子控制器

import UIKit

/// 可重用标识符
private let kTableViewCellIdentifier = "kTableViewCellIdentifier"

/// headerView的高度
private let kHeaderViewHeight: CGFloat = 44

/// headerView的可重用标识符
private let kHeaderViewCellIdentifer = "kHeaderViewCellIdentifer"





class BoutiqueViewController: UIViewController {
    
    // MARK: - 请求网络数据
    
    /// viewModel属性
    fileprivate lazy var boutiqueViewModel: BoutiqueViewModel = BoutiqueViewModel()
    
    
    // MARK: - 懒加载属性
    
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        // 创建tableView
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        // 调整tableView默认的组间距
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 0
        
        // 去掉tableView所有的分割线
        tableView.separatorStyle = .none
        
        // 设置tableView岁父控件一起拉伸
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        tableView.dataSource = self
        
        // 注册cell
        tableView.register(BoutiqueTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        tableView.delegate = self
        
        // 注册headerView
        tableView.register(BoutiqueHeaderView.self, forHeaderFooterViewReuseIdentifier: kHeaderViewCellIdentifer)
        
        return tableView
    }()
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension BoutiqueViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加tableView
        view.addSubview(tableView)
        
        
        tableView.contentInset = UIEdgeInsets(top: 233, left: 0, bottom: 10, right: 0)
        
        // 请求网络数据
        DispatchQueue.global(qos: .default).async {
            self.loadData()
        }
    }
}




// MARK: - 发送网络数据
extension BoutiqueViewController {
    
    /// 请求网络数据
    fileprivate func loadData() {
        
        boutiqueViewModel.requestData {
            
            // 刷新表格
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
            
        }
    }
}





// MARK: - UITableViewDataSource
extension BoutiqueViewController: UITableViewDataSource {
    
    // 返回分组数
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // ViewModel中数组tableModelArray的数量即为分组数
        return boutiqueViewModel.tableModelArray.count
    }
    
    // 返回每一组cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 取出分组模型
        let sectionItem = boutiqueViewModel.tableModelArray[section]
        
        // 从分组模型中取出存放行模型的数组，然后返回该数组的个数
        guard let count = sectionItem.recommends?.count else { return 0 }
        
        return count
    }
    
    // 返回tableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 根据可重用标识符取出cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier) as! BoutiqueTableViewCell
        
        // 先取出分组模型
        let sectionItem = boutiqueViewModel.tableModelArray[indexPath.section]
        
        // 再取出行模型
        let item = sectionItem.tableRecommendModeArray[indexPath.row]
        
        // 设置cell的子标题
        cell.cellSubtitleLabel.text = item.title
        cell.cellImageView.kf.setImage(with: URL(string: item.thumb))
        
        
        /// 它这个主标题很变态，有一部分是存储在parent_info这个
        /// 字典当中的，而有一部分是存储在detail这个字典当中的
        if let infoItem = item.tableParentInfoModelArray.first {
            
            // 如果tableParentInfoModelArray不为空，则主标题为parent_name
            cell.cellTitleLabel.text = infoItem.parent_name
            
        } else if let detailItem = item.tableDetailModelArray.first {
            
            // 否则，cell的主标题为tableDetailModel模型的title
            cell.cellTitleLabel.text = detailItem.title
        }
        
        return cell
    }
}




// MARK: - UITableViewDelegate
extension BoutiqueViewController: UITableViewDelegate {

    // 返回tableView的表头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // 根据可重用标识符去缓存池中取出headerView
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kHeaderViewCellIdentifer) as! BoutiqueHeaderView
        
        let sectionItem = boutiqueViewModel.tableModelArray[section]
        
        headerView.titleLabel.text = sectionItem.name
        
        return headerView
    }

    // 返回headerView的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderViewHeight
    }
    
    // 修改headerView的背景颜色
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // 先判断view是否为BoutiqueHeaderView
        if view.isKind(of: BoutiqueHeaderView.self) {
            
            // 如果是，则修改其背景颜色
            (view as? BoutiqueHeaderView)?.backgroundView?.backgroundColor = .white
        }
    }
    
    // 返回cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 因为是静态cell，为了避免麻烦，直接在
        // 这里写死
        return 90
    }
}



