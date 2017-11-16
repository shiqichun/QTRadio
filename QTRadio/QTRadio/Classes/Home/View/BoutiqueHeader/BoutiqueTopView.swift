//
//  BoutiqueTopView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// Banner的高度
private let kBannerHeight: CGFloat = 145

/// collectionViewCell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"

class BoutiqueTopView: UIView {

    // MARK: - 私有属性
    
    /// topView的高度
    fileprivate var topViewHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// BannerView
    lazy var boutiqueBannerView: BoutiqueBannerView = {
        
        let bannerView = BoutiqueBannerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBannerHeight))
        return bannerView
    }()
    
    /// 底部的分类标题
    lazy var boutiqueCategoryTitleView: BoutiqueCategoryTitleView = {
        
        let view = BoutiqueCategoryTitleView(frame: CGRect(x: 0, y: kBannerHeight, width: kScreenWidth, height: topViewHeight - kBannerHeight))
        return view
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.topViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension BoutiqueTopView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置topView的背景颜色
        backgroundColor = .white
        
        // 添加collectionView
        addSubview(boutiqueBannerView)
        
        // 添加categoryTitleView
        addSubview(boutiqueCategoryTitleView)
    }
}

