//
//  LiveBillboardsView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 通用间距
private let kMargin: CGFloat = 5

/// 图片的高度
private let kImageHeight: CGFloat = 60




class LiveBillboardsView: UIView {
    
    // MARK: - 私有属性
    
    /// 保存dotsView的高度
    fileprivate var billboardsViewHeight: CGFloat
    
    
    // MARK: - 懒加载属性
    
    /// 左边的view
    lazy var leftView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: kMargin, width: (kScreenWidth - kMargin) * 0.5, height: billboardsViewHeight - 2 * kMargin))
        view.backgroundColor = .white
        
        return view
    }()
    
    /// 中间的分割线
    fileprivate lazy var vertiacalLine: UIView = {
        
        let view = UIView(frame: CGRect(x: (kScreenWidth - kMargin) * 0.5, y: 0, width: kMargin, height: billboardsViewHeight))
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return view
    }()
    
    /// 右边的view
    lazy var rightView: UIView = {
        
        let view = UIView(frame: CGRect(x: (kScreenWidth - kMargin) * 0.5 + kMargin, y: kMargin, width: (kScreenWidth - kMargin) * 0.5, height: billboardsViewHeight - 2 * kMargin))
        view.backgroundColor = .white
        
        return view
    }()
    
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.billboardsViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension LiveBillboardsView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 添加leftView
        addSubview(leftView)
        
        // 添加vertiacalLine
        addSubview(vertiacalLine)
        
        // 添加rightView
        addSubview(rightView)
    }
}
