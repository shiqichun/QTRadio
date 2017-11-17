//
//  RecommendHotWordGridCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/14.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// 间距
private let kMargin: CGFloat = 10

class RecommendHotWordGridCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// item的高度
    fileprivate var itemHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// imageView
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: itemHeight - kMargin, height: itemHeight - kMargin))
        imageView.image = UIImage(named: "hotWordIcon_placeholder_22x22_")
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /// titleLabel
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "不知道啥"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.itemHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension RecommendHotWordGridCell {
    
    /// 设置UI界面
    fileprivate func setupUI() {
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // imageView
        contentView.addSubview(cellImageView)
        
        // titleLabel
        contentView.addSubview(cellTitleLabel)
    }
    
    
    // 清除之前的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "hotWordIcon_placeholder_22x22_")
        cellTitleLabel.text = nil
    }
    
    
    override func layoutSubviews() {
        
        // imageView
        cellImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kMargin * 0.5)
            make.left.equalTo(self).offset(kMargin)
            make.bottom.equalTo(self).offset(-(kMargin * 0.5))
            make.width.equalTo(itemHeight - kMargin)
        }
        
        
        
        // titleLabel
        cellTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cellImageView.snp.right).offset(kMargin)
            make.centerY.equalTo(self)
        }
    }
}
