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

/// topView的高度
private let kTopViewHeight: CGFloat = 233



class BoutiqueViewController: UIViewController {
    
    // MARK: - 请求网络数据
    
    /// viewModel属性
    fileprivate lazy var boutiqueViewModel: BoutiqueViewModel = BoutiqueViewModel()
    
    /// playCountModel属性
    
    
    // MARK: - 懒加载属性
    
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        // 创建tableView
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        
        // 让tableView跟随父控件一起拉伸
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 调整tableView默认的组间距
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 0
        
        // 去掉tableView所有的分割线
        tableView.separatorStyle = .none
        
        
        // 设置数据源代理
        tableView.dataSource = self
        
        // 注册cell
        tableView.register(BoutiqueTableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        tableView.delegate = self
        
        // 注册headerView
        tableView.register(BoutiqueHeaderView.self, forHeaderFooterViewReuseIdentifier: kHeaderViewCellIdentifer)
        
        return tableView
    }()
    
    
    /// 顶部的Banner和表格
    fileprivate lazy var topView: BoutiqueTopView = {
        
        let topView = BoutiqueTopView(frame: CGRect(x: 0, y: -kTopViewHeight, width: kScreenWidth, height: kTopViewHeight))
       
        return topView
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
        
        
        
        // 设置tableView的边距。有一点需要注意，由于iOS 11中增加了安全区域的概念，tableView使用grouped样式
        // 时，顶部会默认增加64的空白，底部会默认增加20的空白，一方面可以通过contentInset来进行相应的设置，另
        // 一方面，可以在代理方法中设置heightForFooterInSection和heightForHeaderInSection的高度为一
        // 个极小值CGFloat.leastNormalMagnitude来消除它
        tableView.contentInset = UIEdgeInsets(top: kTopViewHeight, left: 0, bottom: 0, right: 0)
        
        // 添加topView
        tableView.addSubview(topView)
        
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
            
            // 将Banner的模型数据传递过去
            self.topView.boutiqueBannerView.bannerModelArray = self.boutiqueViewModel.bannerModelArray
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
        
        // 取出parentInforItem
        let parentInfoItem = item.tableParentInfoModelArray.first
        
        
        /// 它这个主标题很变态，有一部分是存储在parent_info这个
        /// 字典当中的，而有一部分是存储在detail这个字典当中的
        if let infoItem = parentInfoItem {

            // 如果tableParentInfoModelArray不为空，则主标题为parent_name
            cell.cellTitleLabel.text = infoItem.parent_name

        } else if let detailItem = item.tableDetailModelArray.first {

            // 否则，cell的主标题为tableDetailModel模型的title
            cell.cellTitleLabel.text = detailItem.title
        }
        
        
        // FIXME: - 这里的代码比较挫！先实现需求，后面再慢慢重构
        
        // 如果parent_info这个字典中的数据不为空，此时才需要
        // 设置cell的播放次数图片和label
        if item.tableParentInfoModelArray.count != 0 {
            cell.playCountLabel.isHidden = false
            cell.playImageView.isHidden = false
            
            cell.starImageView1.isHidden = false
            cell.starImageView2.isHidden = false
            cell.starImageView3.isHidden = false
            cell.starImageView4.isHidden = false
            cell.starImageView5.isHidden = false
            
            for playItem in boutiqueViewModel.playCountModelArray {
                if item.tableParentInfoModelArray.first!.parent_id == playItem.id {
                    
                    // 设置playCountLabel的数据
                    cell.playCountLabel.text = playItem.playcount
                    
                    // 处理小星星
                    switch playItem.score {
                        
                    case 1:
                        cell.starImageView1.image = UIImage(named: "halfStar_13x12_")
                        cell.starImageView2.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView3.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                      
                    case 2:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView3.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 3:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "halfStar_13x12_")
                        cell.starImageView3.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 4:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 5:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "halfStar_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                       
                    case 6:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "star_13x12_")
                        cell.starImageView4.image = UIImage(named: "noStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 7:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "star_13x12_")
                        cell.starImageView4.image = UIImage(named: "halfStar_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 8:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "star_13x12_")
                        cell.starImageView4.image = UIImage(named: "star_13x12_")
                        cell.starImageView5.image = UIImage(named: "noStar_13x12_")
                        
                    case 9:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "star_13x12_")
                        cell.starImageView4.image = UIImage(named: "star_13x12_")
                        cell.starImageView5.image = UIImage(named: "halfStar_13x12_")
                        
                    default:
                        cell.starImageView1.image = UIImage(named: "star_13x12_")
                        cell.starImageView2.image = UIImage(named: "star_13x12_")
                        cell.starImageView3.image = UIImage(named: "star_13x12_")
                        cell.starImageView4.image = UIImage(named: "star_13x12_")
                        cell.starImageView5.image = UIImage(named: "star_13x12_")
                    }
                }
            }
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
    
    // 关闭grouped样式底部默认的空白
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}



