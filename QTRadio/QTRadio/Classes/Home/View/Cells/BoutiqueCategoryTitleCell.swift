//
//  BoutiqueCategoryTitleCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class BoutiqueCategoryTitleCell: UICollectionViewCell {
    
    // MARK: - 懒加载属性
    
    /// 标题控件
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "文化"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    /// 小箭头
    lazy var cellArrow: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "my_fav_more_8x12_")
        imageView.isHidden = false
        imageView.sizeToFit()
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
extension BoutiqueCategoryTitleCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 设置cell的边框和颜色
        layer.borderColor = UIColor(r: 245, g: 244, b: 249).cgColor
        layer.borderWidth = 0.7
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加cell的titleLabel
        contentView.addSubview(cellTitleLabel)
        
        // 添加小箭头
        contentView.addSubview(cellArrow)
    }
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 重新布局cellTitleLabel的位置
        cellTitleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        // 布局小箭头的位置
        cellArrow.snp.makeConstraints({ (make) in
            make.left.equalTo(cellTitleLabel.snp.right).offset(5)
            make.centerY.equalTo(cellTitleLabel)
        })
    }
    
    /// 清除之前循环利用的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitleLabel.text = nil
        cellArrow.image = UIImage(named: "my_fav_more_8x12_")
    }
}
