//
//  BoutiqueHeaderView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// 竖线的高度
private let kVerticalLineHeight: CGFloat = 15

// 间距
private let kMargin: CGFloat = 10

class BoutiqueHeaderView: UITableViewHeaderFooterView {

    // MARK: - 懒加载控件
    
    /// 左边红色的竖线
    fileprivate lazy var verticalLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 253, g: 14, b: 21)
        view.layer.cornerRadius = 1.5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    /// 标题控件
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "新品上线"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    /// 右边的箭头
    fileprivate lazy var arrow: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "album_rectange_8x13_")
        imageView.sizeToFit()
        return imageView
    }()
    
    /// 更多控件
    fileprivate lazy var moreLabel: UILabel = {
        
        let label = UILabel()
        label.text = "更多"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    
    // MARK: - 构造函数
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension BoutiqueHeaderView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加竖线
        contentView.addSubview(verticalLine)
        
        // 添加主标题
        contentView.addSubview(titleLabel)
        
        // 添加屏幕右边的小箭头
        contentView.addSubview(arrow)
        
        // 添加moreLabel
        contentView.addSubview(moreLabel)
    }
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局竖线的位置
        verticalLine.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.centerY.equalTo(self)
            make.width.equalTo(3)
            make.height.equalTo(kVerticalLineHeight)
        }
        
        // 布局主标题的位置
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(verticalLine.snp.right).offset(3)
            make.centerY.equalTo(verticalLine)
        }
        
        // 布局小箭头的位置
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-kMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局moreLabel的位置
        moreLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(-3)
            make.centerY.equalTo(arrow)
        }
    }
}
