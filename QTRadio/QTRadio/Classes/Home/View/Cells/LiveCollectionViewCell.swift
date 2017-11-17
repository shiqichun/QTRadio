//
//  LiveCollectionViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// image的宽度和高度是4：3

import UIKit

class LiveCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - 私有属性
    
    /// cell的看宽度
    fileprivate var cellWidth: CGFloat
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    /// cell图片的宽度
    fileprivate var cellImageWidth: CGFloat = 0
    
    /// cell图片的高度
    fileprivate var cellImageHeight: CGFloat = 0
    
    /// nickLabel的宽度
    fileprivate var nickLabelWidth: CGFloat = 0
    
    /// nickLabel的高度
    fileprivate var nickLabelHeight: CGFloat = 0
    
    
    
    
    
    // MARK: - 懒加载属性
    
    /// 图片控件
    lazy var cellImageView: UIImageView = {
        
        // 计算配图的宽度和高度
        cellImageWidth = cellWidth
        cellImageHeight = cellHeight * 3.0 / 4.0  // 图片宽度的四分之三
        
        // 创建imageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "live_placeholder")
        return imageView
    }()
    
    /// nick_name控件(配图下面第一行左边文字)
    lazy var nickLabel: UILabel = {
        
        // 计算nickLabel的宽度和高度
        nickLabelWidth = cellWidth * 0.6  // 图片宽度的5分之3
        nickLabelHeight = cellHeight / 8.0  // 配图底部的label只占到了高度的四分之一，并且它有两行，所以其高度为cell高度的八分之一
        
        let label = UILabel()
        label.text = "你我他音悦台"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    /// tag控件(配图下面第一行右边文字)
    lazy var tagLabel: UILabel = {
        
        let label = UILabel()
        label.text = "#心动女神"
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    /// title控件(配图下面第二行灰色文字)
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "听过最美一句情话"
        label.textColor = .darkGray
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
extension LiveCollectionViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加配图控件
        contentView.addSubview(cellImageView)
        
        // 添加nickLabel
        contentView.addSubview(nickLabel)
        
        // 添加tagLabel
        contentView.addSubview(tagLabel)
        
        // 添加titleLabel
        contentView.addSubview(titleLabel)
    }
    
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局cellImageView的位置
        cellImageView.snp.makeConstraints { (make) in
            make.width.equalTo(cellImageWidth)
            make.height.equalTo(cellImageHeight)
            make.top.equalTo(self)
            make.left.equalTo(self)
        }
        
        // 布局nickLabel的位置
        nickLabel.snp.makeConstraints { (make) in
            make.width.equalTo(nickLabelWidth)
            make.height.equalTo(nickLabelHeight)
            make.top.equalTo(cellImageView.snp.bottom)
            make.left.equalTo(self)
        }
        
        // 布局tagLabel的位置
        tagLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cellWidth * 0.4)
            make.height.equalTo(nickLabel)
            make.top.equalTo(cellImageView.snp.bottom)
            make.left.equalTo(nickLabel.snp.right)
        }
        
        // 布局titleLabel的位置
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cellImageWidth)
            make.height.equalTo(nickLabel)
            make.top.equalTo(nickLabel.snp.bottom)
            make.left.equalTo(self)
        }
    }
    
    
    /// 清空循环利用的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "live_placeholder")
        nickLabel.text = nil
        tagLabel.text = nil
        titleLabel.text = nil
    }
}
