//
//  BoutiqueTableViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 通用间距
private let kMargin: CGFloat = 15

/// 内部间距
private let kInnerMargin: CGFloat = 3

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
    
    /// 小星星
    lazy var starImageView1: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_13x12_")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var starImageView2: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_13x12_")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var starImageView3: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_13x12_")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var starImageView4: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_13x12_")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var starImageView5: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star_13x12_")
        imageView.sizeToFit()
        imageView.isHidden = true
        return imageView
    }()
    
    /// 播放图标
    lazy var playImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playcount_10x10_")
        imageView.isHidden = true
        return imageView
    }()
    
    
    /// 播放次数
    lazy var playCountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "14.9万"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.isHidden = true
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
        
        
        // 添加好多小星星
        contentView.addSubview(starImageView1)
        contentView.addSubview(starImageView2)
        contentView.addSubview(starImageView3)
        contentView.addSubview(starImageView4)
        contentView.addSubview(starImageView5)
        
        // 添加播放图标
        contentView.addSubview(playImageView)
        
        // 添加播放次数label
        contentView.addSubview(playCountLabel)
        
        // 添加底部分割线
        contentView.addSubview(bottomLine)
    }
    
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局cellImageView的位置
        cellImageView.snp.makeConstraints { (make) in
            make.width.equalTo(kCellImageViewWidth)
            make.height.equalTo(kCellImageViewWidth)
            make.top.equalTo(self).offset(kMargin)
            make.left.equalTo(self).offset(kMargin)
        }
        
        // 布局cellTitleLabel的位置
        cellTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellImageView.snp.top).offset(kInnerMargin)
            make.left.equalTo(cellImageView.snp.right).offset(kMargin)
            make.right.equalTo(self).offset(-kMargin)
        }
        
        // 布局cellSubtitleLabel的位置
        cellSubtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(2 * kInnerMargin)
            make.left.equalTo(cellTitleLabel.snp.left)
            make.right.equalTo(self).offset(-kMargin)
        }
        
        // 布局starImageView1
        starImageView1.snp.makeConstraints { (make) in
            make.top.equalTo(cellSubtitleLabel.snp.bottom).offset(2 * kInnerMargin)
            make.left.equalTo(cellImageView.snp.right).offset(kMargin)
        }
        
        // 布局starImageView2
        starImageView2.snp.makeConstraints { (make) in
            make.top.equalTo(starImageView1)
            make.left.equalTo(starImageView1.snp.right).offset(kInnerMargin)
        }
        
        // 布局starImageView3
        starImageView3.snp.makeConstraints { (make) in
            make.top.equalTo(starImageView2)
            make.left.equalTo(starImageView2.snp.right).offset(kInnerMargin)
        }
        
        // 布局starImageView4
        starImageView4.snp.makeConstraints { (make) in
            make.top.equalTo(starImageView3)
            make.left.equalTo(starImageView3.snp.right).offset(kInnerMargin)
        }
        
        // 布局starImageView5
        starImageView5.snp.makeConstraints { (make) in
            make.top.equalTo(starImageView4)
            make.left.equalTo(starImageView4.snp.right).offset(kInnerMargin)
        }
        
        // 布局playImageView
        playImageView.snp.makeConstraints { (make) in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.right.equalTo(playCountLabel.snp.left).offset(-kInnerMargin)
            make.centerY.equalTo(playCountLabel)
        }
        
        // 布局playCountLabel的位置
        playCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellSubtitleLabel.snp.bottom).offset(2 * kInnerMargin)
            make.right.equalTo(self).offset(-kMargin)
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
        
        // 处理播放小图标
        playImageView.isHidden = true
        playCountLabel.isHidden = true
        playCountLabel.text = nil
        
        // 处理小星星
        starImageView1.isHidden = true
        starImageView1.image = UIImage(named: "noStar_13x12_")
        starImageView2.isHidden = true
        starImageView2.image = UIImage(named: "noStar_13x12_")
        starImageView3.isHidden = true
        starImageView3.image = UIImage(named: "noStar_13x12_")
        starImageView4.isHidden = true
        starImageView4.image = UIImage(named: "noStar_13x12_")
        starImageView5.isHidden = true
        starImageView5.image = UIImage(named: "noStar_13x12_")
        
    }
}
