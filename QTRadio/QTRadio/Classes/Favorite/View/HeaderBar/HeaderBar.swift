//
//  HeaderBar.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/6.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// cell距离屏幕左右的间距
private let kMarigin: CGFloat = 10

class HeaderBar: UIView {

    // MARK: - 懒加载属性
    
    /// 顶部分割线
    fileprivate lazy var topLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
extension HeaderBar {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加底部的分割线
        addSubview(topLine)
    }
    
    // 重新布局子控件
    override func layoutSubviews() {
        
        
        // 布局顶部分割线的位置
        topLine.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(0.4)
        }
    }
    
}
