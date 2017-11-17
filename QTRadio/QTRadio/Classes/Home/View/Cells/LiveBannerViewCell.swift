//
//  LiveBannerViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class LiveBannerViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    
    
    // MARK: - 懒加载属性
    
    /// 图片控件
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView(frame: bounds)
        imageView.image = UIImage(named: "banner_placeholder_375x145_")
        return imageView
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension LiveBannerViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 删除contentView的所有子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加图片控件
        contentView.addSubview(cellImageView)
    }
    
    /// 清除循环利用的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "banner_placeholder_375x145_")
    }
}
