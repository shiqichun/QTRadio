//
//  BannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class BannerView: UIView {
    
    // MARK: - 私有属性
    
    /// 保存Banner的宽度
    fileprivate var bannerWidth: CGFloat
    
    /// 保存Banner的高度
    fileprivate var bannerHeight: CGFloat
    
    /// 保存layout
    fileprivate var bannerLayout: UICollectionViewFlowLayout
    

    // MARK: - 懒加载控件
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: bannerLayout)
        
        return collectionView
    }()
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, UICollectionViewFlowLayout layout: UICollectionViewFlowLayout) {
        
        // 初始化私有控件
        self.bannerWidth = frame.size.width
        self.bannerHeight = frame.size.height
        self.bannerLayout = layout
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




// MARK: - 设置UI界面
extension BannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 先移除
    }
}
