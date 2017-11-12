//
//  RecommendViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class RecommendViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// cell的宽度
    fileprivate var cellWidth: CGFloat
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    
    // MARK: - 懒加载控件属性
    
    /// 图片
    lazy var cellImageView: UIImageView = {
        
        let cellImageView = UIImageView()
        cellImageView.backgroundColor = .white
        cellImageView.image = UIImage(named: "recommend_placeholder_95x95_")
        return cellImageView
    }()
    
    
    /// 标题
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "虎口夺食，暗箭上弦"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
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
    }
    
    ///
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
    }
    
}
