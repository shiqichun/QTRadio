//
//  RecommendViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 负责管理推荐界面

import UIKit

/// 通用间距
private let kMargin: CGFloat = 5

/// coverView和cell高度之间的比率
private let kRate: CGFloat = 0.2


class RecommendViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// cell的宽度
    fileprivate var cellWidth: CGFloat
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    
    // MARK: - 懒加载控件属性
    
    /// cell的图片控件
    lazy var cellImageView: UIImageView = {
        
        let cellImageView = UIImageView()
        cellImageView.backgroundColor = .white
        cellImageView.image = UIImage(named: "recommend_placeholder_95x95_")
        return cellImageView
    }()
    
    
    /// cell的标题控件
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "虎口夺食，暗箭上弦"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 0
        return label
    }()
    
    /// cell的播放图标控件
    fileprivate lazy var playImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "playcountWhite_10x10_")
        imageView.sizeToFit()
        return imageView
    }()
    
    /// cell图片底部的渐变阴影控件
    fileprivate lazy var coverView: UIView = {
        
        let view = UIView()
        
        // 创建渐变层
        let gradientlayer: CAGradientLayer = CAGradientLayer()
        gradientlayer.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight * kRate)
        gradientlayer.colors = [(UIColor.clear.cgColor),(UIColor.lightGray.cgColor)]
        gradientlayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientlayer, at: 0)
        
        return view
    }()
    
    /// cell图片控件底部显示播放量的label
    lazy var playCountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "50亿"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.cellWidth = frame.size.width
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
extension RecommendViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加cellImageView
        contentView.addSubview(cellImageView)
        
        // 添加cellTitleLabel
        contentView.addSubview(cellTitleLabel)
        
        // 添加coverView
        cellImageView.addSubview(coverView)
        
        // 添加播放图标
        coverView.addSubview(playImageView)

        // 添加播放量label
        coverView.addSubview(playCountLabel)
    }
    
    /// 重新布局子控件
    override func layoutSubviews() {
        
        // 布局cellImageView
        cellImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.width.equalTo(cellWidth)
            make.height.equalTo(cellWidth)
        }
        
        // 布局cellTitleLabel
        cellTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cellImageView.snp.bottom)
            make.left.equalTo(self)
            make.width.equalTo(cellWidth)
            make.height.equalTo(cellHeight - cellWidth)
        }
        
        // 布局coverView的位置
        coverView.snp.makeConstraints { (make) in
            make.width.equalTo(cellWidth)
            make.height.equalTo(cellHeight * kRate)
            make.left.equalTo(cellImageView.snp.left)
            make.bottom.equalTo(cellImageView.snp.bottom)
        }
        
        // 布局播放图标的位置
        playImageView.snp.makeConstraints { (make) in
            make.left.equalTo(cellImageView.snp.left).offset(kMargin)
            make.bottom.equalTo(cellImageView.snp.bottom).offset(-kMargin)
        }

        // 布局playCountLabel的位置
        playCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(playImageView.snp.right).offset(kMargin)
            make.centerY.equalTo(playImageView.snp.centerY)
        }
    }
    
    
    /// 清除之前的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitleLabel.text = nil
        cellImageView.image = UIImage(named: "recommend_placeholder_95x95_")
        playCountLabel.text = nil
    }
}
