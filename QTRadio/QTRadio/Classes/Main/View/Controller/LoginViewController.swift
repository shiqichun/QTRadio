//
//  LoginViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理点击登录按钮时的登录界面(存在内存泄漏)

import UIKit

/// topView的高度
private let kTopViewHeight: CGFloat = kScreenHeight * 0.15  // 这里有问题？

/// bottomView的高度
private let kBottomViewHeight: CGFloat = kScreenHeight * 0.375




class LoginViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// 顶部view
    fileprivate lazy var topView: UIView = {
        
        let topViewFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kTopViewHeight)
        let topView = TopView(frame: topViewFrame, parentVc: self)
        
        return topView
    }()
    
    /// 中间view
    fileprivate lazy var centerView: UIView = {
        
        let centerViewFrame = CGRect(x: 0, y: kTopViewHeight, width: kScreenWidth, height: kScreenHeight - kTopViewHeight - kBottomViewHeight)
        let centerView = CenterView(frame: centerViewFrame, parentVc: self)
        
        return centerView
    }()
    
    /// 底部view
    fileprivate lazy var bottomView: UIView = {
        
        let bottomViewFrame = CGRect(x: 0, y: kScreenHeight - kBottomViewHeight, width: kScreenWidth, height: kBottomViewHeight)
        let bottomView = BottomView(frame: bottomViewFrame, parentVc: self)
        
        return bottomView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 统一设置UI界面
        setupUI()
    }

}


// MARK: - 设置UI界面
extension LoginViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加所有的子控件
        addSubviews()
    }
    
    /// 添加所有的子控件
    fileprivate func addSubviews() {
        
        // 添加topView
        view.addSubview(topView)
        
        // 添加centerView
        view.addSubview(centerView)
        
        // 添加bottomView
        view.addSubview(bottomView)
    }
}
