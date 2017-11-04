//
//  AlbumViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/4.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class AlbumViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// 图片控件
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_image_loading_default")
        return imageView
    }()
    
    /// 标题控件
    var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "我一见你就笑，你那翩翩风采你那翩翩风采你那翩翩风采"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MAKR: - 设置UI界面
extension AlbumViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 将imageView添加到cell的contentView中
        contentView.addSubview(imageView)
        
        // 将titleLabel添加到cell的contentView中
        contentView.addSubview(titleLabel)
    }
    
    
    override func layoutSubviews() {
        
        // 布局图片控件的frame
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        
        // 布局titleLabel
        titleLabel.frame = CGRect(x: 0, y: bounds.width, width: bounds.width, height: bounds.height - bounds.width)
    }
}
