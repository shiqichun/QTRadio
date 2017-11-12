//
//  RecommendBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/11.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 推荐界面的无线轮播器(或者说banner)

import UIKit
import SnapKit


/// collectionViewCell标识符
private let kBannerCellIdentifier = "kBannerCellIdentifier"

/// recommendIndicator的高度
private let kRecommendIndicatorHeight: CGFloat = 3

class RecommendBannerView: UIView {
    
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
        return 6
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCellIdentifier, for: indexPath) as! RecommendBannerViewCell
        
        return cell
    }
}
