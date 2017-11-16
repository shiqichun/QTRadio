//
//  BoutiqueTableViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 通用间距
private let kMargin: CGFloat = 10

/// cellImageView的宽度
private let kCellImageViewWidth: CGFloat = 70

class BoutiqueTableViewCell: UITableViewCell {

    // MAKR: - 懒加载控件
    
    /// cell的配图
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recommend_placeholder_95x95_")
        return imageView
    }()
    
    /// cell的主标题
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    /// cell的副标题
    lazy var cellSubtitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    /// cell底部的分割线
    fileprivate lazy var bottomLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return view
    }()
    
    
    // MARK: - 构造函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension BoutiqueTableViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加cell的配图
        contentView.addSubview(cellImageView)
        
        // 添加titleLabel
        contentView.addSubview(cellTitleLabel)
        
        // 添加cellSubtitleLabel
        contentView.addSubview(cellSubtitleLabel)
        
        // 如果只有一个cell，则不需要添加
        
        // 添加底部分割线
        contentView.addSubview(bottomLine)
    }
    
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局cellImageView的位置
        cellImageView.snp.makeConstraints { (make) in
            make.width.equalTo(kCellImageViewWidth)
            make.height.equalTo(kCellImageViewWidth)
            make.top.equalTo(self).offset(kMargin)
            make.left.equalTo(self).offset(kMargin)
        }
        
        // 布局cellTitleLabel的位置
        cellTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellImageView.snp.top).offset(kMargin * 0.5)
            make.left.equalTo(cellImageView.snp.right).offset(kMargin)
        }
        
        // 布局cellSubtitleLabel的位置
        cellSubtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(kMargin * 0.5)
            make.left.equalTo(cellTitleLabel.snp.left)
        }
        
        // 布局bottomLine的位置
        bottomLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(cellImageView.snp.left)
            make.bottom.equalTo(self)
            make.right.equalTo(self).offset(-kMargin)
        }
    }
    
    /// 清除循环利用的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "recommend_placeholder_95x95_")
        cellTitleLabel.text = nil
        cellSubtitleLabel.text = nil
    }
}
