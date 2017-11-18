//
//  RecommendPageControl.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/18.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


class RecommendPageControl: UIPageControl {

    // MARK: - 私有属性
    
    /// pageControl的宽度
    fileprivate var pageControlWidth: CGFloat
    
    /// pageControl高度
    fileprivate var pageControlHeight: CGFloat
    
    
    
    // MARK: - 懒加载控件
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有控件
        self.pageControlWidth = frame.size.width
        self.pageControlHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension RecommendPageControl {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置pageControl的相关属性
        numberOfPages = 6
        pageIndicatorTintColor = .blue
        currentPageIndicatorTintColor = .brown
        
        // 利用KVC重新设置pageControl小圆点的图片
        setValue(UIImage(named: "pageImage"), forKey: "_pageImage")
        setValue(UIImage(named: "currentPageImage"), forKey: "_currentPageImage")
    }
    
    
    fileprivate func getPrivatePropertyName() {
        
        // 利用runtime遍历出UIPageControl所有的属性(包括私有属性)
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIPageControl.self, &count)
        
        for i in 0..<count {
            
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar!)
            print(String(cString: name!))
        }
    }
}
