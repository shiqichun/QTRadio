//
//  TopView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class TopView: UIView {

    // MARK: - 私有属性
    
    /// 保存父控制器
    fileprivate var parentVc: UIViewController
    
    
    // MARK: - 懒加载属性
    
    /// 关闭按钮
    fileprivate lazy var closeBtn: UIButton = {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "icon_evaluation_close"), for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    /// 标题控件
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "登录"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    
    // MARK: - 构造函数
    
    init(frame: CGRect, parentVc: UIViewController) {
        
        // 初始化私有属性
        self.parentVc = parentVc
        
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
extension TopView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加关闭按钮
        addSubview(closeBtn)
        closeBtn.frame.origin.x = 10
        closeBtn.frame.origin.y = kStatusBarHeight
        
        
        // 添加标题
        addSubview(titleLabel)
        titleLabel.center.x = center.x
        titleLabel.frame.origin.y = kStatusBarHeight
    }
}


// MARK: - 监听事件的点击
extension TopView {
    
    /// 监听关闭按钮的点击
    @objc fileprivate func closeBtnClick() {
        
        parentVc.dismiss(animated: true, completion: nil)
    }
}
