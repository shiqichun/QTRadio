//
//  LiveDotsViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class LiveDotsViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    
    /// cell的宽度
    fileprivate var cellWidth: CGFloat
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// 图片控件
    lazy var cellImageView: UIImageView = {
        
        let imageView = UIImageView(frame: bounds)
        imageView.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return imageView
    }()
    
    /// 标题控件
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    
    
    /// 阴影控件
    fileprivate lazy var shadowView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: cellHeight * 0.6, width: cellWidth, height: cellHeight * 0.4))
        
        // 创建渐变层
        let gradientlayer: CAGradientLayer = CAGradientLayer()
        gradientlayer.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight * 0.4)
        gradientlayer.colors = [(UIColor.clear.cgColor),(UIColor.lightGray.cgColor)]
        gradientlayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientlayer, at: 0)
        
        
        return view
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
extension LiveDotsViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的圆角
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // 移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加cellImageView
        contentView.addSubview(cellImageView)
        
        // 添加阴影控件
        cellImageView.addSubview(shadowView)
        
        // 添加标题控件
        shadowView.addSubview(titleLabel)
    }
    
    /// 布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局titleLabel的位置
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(shadowView)
        }
    }
    
    /// 清空循环利用回来的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = nil
        titleLabel.text = nil
    }
}
