//
//  RecommendBannerViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 无线轮播器(Banner)的cell

import UIKit

class RecommendBannerViewCell: UICollectionViewCell {
    
    // MARK: -
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// imageView
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView(frame: self.bounds)
        imageView.image = UIImage(named: "banner_placeholder_375x145_")
        imageView.sizeToFit()
        return imageView
    }()
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.cellHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension RecommendBannerViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 将cellImageView添加到contentView中
        contentView.addSubview(cellImageView)
    }
    
    
    /// 清除之前的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = nil
    }
}
