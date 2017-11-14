//
//  RecommendBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/11.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 推荐界面的无线轮播器(或者说banner)

import UIKit


/// collectionViewCell标识符
private let kBannerCellIdentifier = "kBannerCellIdentifier"

/// recommendIndicator的高度
private let kRecommendIndicatorHeight: CGFloat = 3

class RecommendBannerView: UIView {
    
    
    // MARK: - 模型属性
    
    // 用于接收从控制器传递过来的模型数据
    var bannerModelArray: [BannerModel]? {
        
        didSet {
            
            // 监听bannerModelArray的改变
            // 然后刷新表格，重新载入数据
            recommendBannerView.reloadData()
        }
    }
    
    
    
    
    
    // MARK: - 私有属性
    
    /// bannerViewHeight
    fileprivate var bannerViewHeight: CGFloat

    // MARK: - 控件属性
    
    /// collectionView控件
    lazy var recommendBannerView: UICollectionView = {
        
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: bannerViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: bannerViewHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        // 设置数据源代理，并注册cell
        collectionView.dataSource = self
        collectionView.register(RecommendBannerViewCell.self, forCellWithReuseIdentifier: kBannerCellIdentifier)
        
        return collectionView
    }()
    
    /// pageControl控件
    lazy var recommendIndicator: UIView = {
        let recommendIndicator = UIView()
        recommendIndicator.frame = CGRect(x: 0, y: bannerViewHeight - kRecommendIndicatorHeight, width: 50, height: kRecommendIndicatorHeight)
        recommendIndicator.backgroundColor = UIColor(r: 214, g: 51, b: 52)
        return recommendIndicator
    }()
    
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.bannerViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension RecommendBannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        addSubview(recommendBannerView)
        
        // 添加pageControl
        addSubview(recommendIndicator)
    }
}



// MARK: - UICollectionViewDataSource
extension RecommendBannerView: UICollectionViewDataSource {
    
    // 返回cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 首先校验数组bannerModelArray是否有值
        guard let bannerModelArray = bannerModelArray else { return 0 }
        
        // 接着取出组模型
        let typeItem = bannerModelArray[section]
        
        // 然后取出title模型
        guard let titleItem = typeItem.bannerDataModelArray.first else { return 0 }
        
        // 接着取出标题模型数组中存放数据的数组data，其中data的个数即为cell的个数
        guard let count = titleItem.data?.count else { return 0 }
        
        return count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCellIdentifier, for: indexPath) as! RecommendBannerViewCell
        
        // 首先校验数组bannerModelArray是否有值
        guard let bannerModelArray = bannerModelArray else { return cell }
        
        // 接着取出分组模型
        let typeItem = bannerModelArray[indexPath.section]
        
        // 然后取出标题模型
        guard let titleItem = typeItem.bannerDataModelArray.first else { return cell }
        
        // 最后取出行模型
        let dataItem = titleItem.bannerDataDataModelArray[indexPath.row]
        
        // 设置数据
        cell.cellImageView.kf.setImage(with: URL(string: dataItem.imgUrl))
        
        return cell
    }
}
