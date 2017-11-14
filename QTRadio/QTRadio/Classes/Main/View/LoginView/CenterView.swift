//
//  CenterView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 主要是用来管理中间登录界面的logo，以及新用户注册按钮和使用手机登录按钮

import UIKit


/// 按钮距离屏幕两边的距离
private let kMargin: CGFloat = 80

/// 按钮的高度
private let kButtonHeight: CGFloat = 44

class CenterView: UIView {

    // MARK: - 私有属性
    
    /// 保存父控制器
    fileprivate var parentVc: UIViewController
    
    
    // MARK: - 懒加载属性
    
    /// logo  -
    fileprivate lazy var logoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phoneLogin_83x147_")
        imageView.sizeToFit()
        return imageView
    }()
    
    /// 新用户注册按钮 icon_input_record_indicator_cancel
    fileprivate lazy var newUserBtn: UIButton = {
    
        // 创建新用户注册按钮
        let btn = UIButton(imageName: "icon_input_record_indicator_cancel", title: "新用户注册")
        
        // 监听新用户注册按钮的点击
        btn.addTarget(self, action: #selector(newUserBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    /// 使用手机登录按钮
    fileprivate lazy var phoneNumBtn: UIButton = {
        
        // 创建手机号码登录按钮
        let btn = UIButton(imageName: "backgroundImage", title: "使用手机号登录")
        
        // 设置按钮文字颜色为红色
        btn.setTitleColor(.red, for: .normal)
        
        // 给按钮设置红色的边框
        btn.layer.borderColor = (UIColor.red).cgColor
        
        // 设置边框的粗细
        btn.layer.borderWidth = 1.0
        
        // 监听手机号码登录按钮的点击
        btn.addTarget(self, action: #selector(phoneNumBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    // MARK: - 构造函数
    
    init(frame: CGRect, parentVc: UIViewController) {
        
        // 初始化私有属性
        self.parentVc = parentVc
        
        // 初始化父类属性
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



// MARK: - 设置UI界面
extension CenterView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加logoImageView
        addSubview(logoImageView)
        
        // 添加新用户注册按钮
        addSubview(newUserBtn)
        
        // 添加手机号码登录按钮
        addSubview(phoneNumBtn)
    }
    
    
    override func layoutSubviews() {
        
        // 布局logoImageView的位置
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        // 对新用户注册按钮进行布局
        newUserBtn.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(kMargin)
            make.right.equalTo(self).offset(-kMargin)
            make.height.equalTo(kButtonHeight)
        }
        
        // 对手机号码登录按钮进行布局
        phoneNumBtn.snp.makeConstraints { (make) in
            make.top.equalTo(newUserBtn.snp.bottom).offset(20)
            make.left.equalTo(self).offset(kMargin)
            make.right.equalTo(self).offset(-kMargin)
            make.height.equalTo(kButtonHeight)
        }
    }
}



// MARK: - 监听事件的点击
extension CenterView {
    
    /// 监听新用户注册按钮的点击
    @objc fileprivate func newUserBtnClick() {
        
        print("CenterView---newUserBtnClick")
    }
    
    /// 监听手机号登录按钮的点击
    @objc fileprivate func phoneNumBtnClick() {
        
        print("CenterView---phoneNumBtnClick")
    }
}

