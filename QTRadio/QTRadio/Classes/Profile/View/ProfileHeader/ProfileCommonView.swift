//
//  ProfileCommonView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/8.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import SnapKit

/// 通用间距
private let kMargin: CGFloat = 10

class ProfileCommonView: UIView {
    
    // MARK: - 私有属性
    
    /// 图片控件的名称
    fileprivate var imageName: String
    
    /// 主标题
    fileprivate var title: String
    
    /// 副标题
    fileprivate var subtitle: String

    // MARK: - 懒加载控件
    
    /// 图片控件
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.sizeToFit()
        return imageView
    }()
    
    /// 主标题控件
    fileprivate lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        sizeToFit()
        return titleLabel
    }()
    
    /// 副标题控件
    fileprivate lazy var subtitleLabel: UILabel = {
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = .lightGray
        return subtitleLabel
    }()
    
    
    
    
    // MARK: - 自定义构造函数
    
    /// 自定义构造函数，根据实际需要返回控件
    /// - 参数imageName：表示图片的名称
    /// - 参数title：表示主标题
    /// - 参数subtitle：表示副标题
    init(frame: CGRect, imageName: String, title: String, subtitle: String) {
        
        // 初始化私有属性
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        
        // 初始化父类属性
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - 设置UI界面
extension ProfileCommonView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加图片控件
        addSubview(imageView)
        
        // 添加主标题控件
        addSubview(titleLabel)
        
        // 添加副标题控件
        addSubview(subtitleLabel)
    }
    
    
    // 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局图片控件的位置
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(kMargin)
        }
        
        // 布局主标题控件的位置
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top)
            make.left.equalTo(imageView.snp.right).offset(2 * kMargin)
        }
        
        // 布局副标题的位置
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(2 * kMargin)
            make.bottom.equalTo(imageView.snp.bottom)
        }
    }
}
