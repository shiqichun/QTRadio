//
//  RecommendReusableView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import SnapKit


/// 间距
private let kMargin: CGFloat = 15

/// 分割条的高度
private let kSeperateLineHeight: CGFloat = 5

class RecommendReusableView: UICollectionReusableView {
    
    // MARK: - 私有属性
    
    
    // MARK: - 对外公开属性
    
    
    // MARK: - 懒加载属性
    
    /// 顶部分割线
    fileprivate lazy var seperateLine: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kSeperateLineHeight))
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return view
    }()
    
    /// titleLabel
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "精品内容"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    /// imageView
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "album_rectange_8x13_")
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
extension RecommendReusableView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加顶部分割线
        addSubview(seperateLine)
        
        // 添加titl
        addSubview(titleLabel)
        
        // 添加imag
        addSubview(imageView)
    }
    
    /// 布局子控件
    override func layoutSubviews() {
        
        // 布局titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.centerY.equalTo(self).offset(kSeperateLineHeight * 0.5)
        }
        
        
        // 布局imageView
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(kMargin * 0.5)
            make.centerY.equalTo(self).offset(kSeperateLineHeight * 0.5)
        }
    }
}
