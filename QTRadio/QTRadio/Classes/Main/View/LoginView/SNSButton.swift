//
//  SNSButton.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class SNSButton: UIButton {
    
    // MARK: 私有属性
    
    /// 普通状态下的图片名称
    fileprivate var imageName: String
    
    /// 高亮状态下图片的名称
    fileprivate var hightlightImageName: String
    
    /// 按钮标题的名称
    fileprivate var title: String
    
    
    /// 按钮中图片控件的宽度
    fileprivate var imageViewWidth: CGFloat
    
    /// 按钮中图片控件的高度
    fileprivate var imageViewHeight: CGFloat
    
    /// 按钮中标题控件的高度
    fileprivate var titleLabelHeight: CGFloat
    
    
    // MARK: - 自定义构造函数
    
    /// 根据给定的图片和标题自定义按钮
    /// - 参数imageName：表示按普通状态下的背景图片
    /// - 参数hightlightImageName：表示按钮高亮状态下的背景图片，如果没有，可以不传
    /// - 参数title：表示按钮的标题
    init(frame: CGRect, imageName: String, hightlightImageName: String = "", title: String) {
        
        // 初始化稀有属性
        self.imageName = imageName
        self.hightlightImageName = hightlightImageName
        self.title = title
        
        // 保存按钮中图片控件的尺寸和标题控件的高度
        self.imageViewWidth = frame.size.width
        self.imageViewHeight = imageViewWidth
        self.titleLabelHeight = frame.size.height - imageViewWidth
        
        // 初始化父类的属性
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 重新设置imageView的frame
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {

        return CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight)
    }


    /// 重新设置titleLabel的frame
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: imageViewHeight, width: imageViewWidth, height: titleLabelHeight)
    }

}



// MARK: 设置UI界面
extension SNSButton {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置按钮的标题
        setTitle(title, for: .normal)
        
        // 设置按钮普通状态下的背景图片
        setBackgroundImage(UIImage(named: imageName), for: .normal)
        
        // 如果有高亮状态下的背景图片，则将其设置上去
        if hightlightImageName != "" {
            setBackgroundImage(UIImage(named: hightlightImageName), for: .highlighted)
        }
        
        // 设置按钮中字体的颜色
        setTitleColor(.darkGray, for: .normal)
        
        // 设置按钮中字体的大小
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        // 设置按钮中文字居中显示
        titleLabel?.textAlignment = .center
    }
}
