//
//  ItemView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/9.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    // MARK: - 私有属性
    
    /// 保存图片的名称
    fileprivate var imageName: String
    
    /// 保存标题
    fileprivate var title: String
    

    // MARK: - 懒加载属性
    
    /// 图片控件
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    /// 文字控件
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = title
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    // MARK: - 自定义构造函数
    
    /// 自定义控件
    /// - 参数frame：表示控件的frame
    /// - 参数imageName：表示图片的名称
    /// - 参数title：表示标题的名称
    init(frame: CGRect, imageName: String, title: String) {
        
        // 初始化私有属性
        self.imageName = imageName
        self.title = title
        
        // 初始化父类的属性
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension ItemView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加图片控件
        addSubview(imageView)
        
        // 添加文字控件
        addSubview(titleLabel)
    }
    
    
    /// 布局子控件的位置
    override func layoutSubviews() {
        
        // 布局imageView控件
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(30)
        }
        
        // 布局titleLabel控件
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(imageView.snp.right).offset(10)
        }
    }
}
