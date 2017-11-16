//
//  BoutiqueBannerCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class BoutiqueBannerCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// Banner的高度
    fileprivate var bannerHeight: CGFloat
    
    // MARK: - 懒加载控件
    
    /// bannerCell的图片控件
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView(frame: bounds)
        imageView.image = UIImage(named: "banner_placeholder_375x145_")
        return imageView
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.bannerHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension BoutiqueBannerCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加cellImageView
        contentView.addSubview(cellImageView)
    }
    
    /// 清除旧的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "banner_placeholder_375x145_")
    }
}
