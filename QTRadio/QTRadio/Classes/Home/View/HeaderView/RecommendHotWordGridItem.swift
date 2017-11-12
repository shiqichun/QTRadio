//
//  RecommendHotWordGridItem.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import SnapKit


/// 间距
private let kMargin: CGFloat = 10

class RecommendHotWordGridItem: UIView {
    
    // MARK: - 私有属性
    
    /// item的高度
    fileprivate var itemHeight: CGFloat
    
    /// imageName
    fileprivate var imageName: String
    
    /// title
    fileprivate var title: String

    // MARK: - 懒加载属性
    
    /// imageView
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: itemHeight - kMargin, height: itemHeight - kMargin))
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    /// titleLabel
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = title
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // MARK: - 构造函数
    init(frame: CGRect, imageName: String, title: String) {
        
        // 初始化私有属性
        self.itemHeight = frame.size.height
        self.imageName = imageName
        self.title = title
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension RecommendHotWordGridItem {
    
    /// 设置UI界面
    fileprivate func setupUI() {
        
        // imageView
        addSubview(imageView)
        
        // titleLabel
        addSubview(titleLabel)
    }
    
    
    override func layoutSubviews() {
        
        // imageView
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kMargin * 0.5)
            make.left.equalTo(self).offset(kMargin)
            make.bottom.equalTo(self).offset(-(kMargin * 0.5))
            make.width.equalTo(itemHeight - kMargin)
        }
        
        
        
        // titleLabel
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(kMargin)
            make.centerY.equalTo(self)
        }
    }
}
