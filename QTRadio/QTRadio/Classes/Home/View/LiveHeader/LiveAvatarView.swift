//
//  LiveAvatarView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/18.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 头像的宽高都是40，重叠部分为15

import UIKit

/// 重叠部分的宽度
private let kOverlap: CGFloat = 5

class LiveAvatarView: UIView {

    // MARK: - 私有属性
    
    /// avatar控件的宽度
    fileprivate var avatarViewWidth: CGFloat
    
    /// avatar控件的高度
    fileprivate var avatarViewHeight: CGFloat
    
    /// 头像的宽度和高度
    fileprivate var iconWidth: CGFloat = 0
    
    
    
    // MARK: - 懒加载属性
    
    /// 右边的头像
    lazy var rightIcon: UIImageView = {
        
        iconWidth = (avatarViewWidth + 2 * kOverlap) / 3.0
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.randomColor().cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    /// 中间的头像
    lazy var centerIcon: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.randomColor().cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    
    
    /// 左边的头像
    lazy var leftIcon: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        imageView.layer.cornerRadius = iconWidth * 0.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.randomColor().cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.avatarViewWidth = frame.size.width
        self.avatarViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension LiveAvatarView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加左边的头像
        addSubview(rightIcon)
        
        // 添加中间的头像
        addSubview(centerIcon)
        
        // 添加左边的头像
        addSubview(leftIcon)
    }
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局leftIcon的位置
        rightIcon.snp.makeConstraints { (make) in
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
            make.right.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        // 布局中间头像的位置
        centerIcon.snp.makeConstraints { (make) in
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
            make.right.equalTo(rightIcon.snp.left).offset(kOverlap)
            make.centerY.equalTo(self)
        }
        
        // 布局左边的头像
        leftIcon.snp.makeConstraints { (make) in
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
            make.right.equalTo(centerIcon.snp.left).offset(kOverlap)
            make.centerY.equalTo(self)
        }
    }
}
