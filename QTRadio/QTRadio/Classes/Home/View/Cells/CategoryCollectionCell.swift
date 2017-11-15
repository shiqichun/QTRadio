//
//  CategoryCollectionCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/10.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// cell的高度
    fileprivate var cellWidth: CGFloat
    
    /// cell的宽度
    fileprivate var cellHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// 图片控件
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "category_01")
        return imageView
    }()
    
    /// 标题控件
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "相声小品"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    // MARK: - 自定义构造函数
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
extension CategoryCollectionCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 先移除cell里面所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加imageView控件
        contentView.addSubview(imageView)
        
        // 添加titleLabel控件
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        
        // 布局imageView的位置
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(cellWidth * 0.4)
            make.height.equalTo(cellWidth * 0.4)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        // 布局titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
    
    
    /// 清除之前的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
}
