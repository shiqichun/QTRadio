//
//  CategoryHeaderView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/9.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 间距
private let kMargin: CGFloat = 5

class CategoryHeaderView: UIView {

    // MARK: - 私有属性
    
    /// headerView的高度
    fileprivate var categoryHeaderViewHeight: CGFloat
    
    // MARK: - 懒加载属性
    
    /// 分类headerView的上半部分
    fileprivate lazy var categoryTopView: UIView = {
        
        let categoryTopView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: categoryHeaderViewHeight * 0.7))
        categoryTopView.backgroundColor = .white
        return categoryTopView
    }()
    
    /// 分类headerView的下半部分
    fileprivate lazy var categoryBottomView: CategoryBottomView = {
        
        let categoryBottomView = CategoryBottomView(frame: CGRect(x: 0, y: categoryHeaderViewHeight * 0.7 + kMargin, width: kScreenWidth, height: categoryHeaderViewHeight * 0.3 - kMargin))
        return categoryBottomView
    }()
    
    
    // MARK: - 自定义构造函数
    
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.categoryHeaderViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - 设置UI界面
extension CategoryHeaderView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置headerView的背景颜色
        backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 添加headerView的上半部分
        addSubview(categoryTopView)
        
        // 添加headerView的下半部分
        addSubview(categoryBottomView)
    }
}
