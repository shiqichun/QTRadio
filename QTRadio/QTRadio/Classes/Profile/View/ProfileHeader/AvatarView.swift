//
//  AvatarView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/8.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    // MARK: - 控件属性
    
    /// 用户头像(圆形)
    @IBOutlet weak var avatar: UIImageView!
    
    /// 点击登录按钮
    @IBOutlet weak var loginBtn: UIButton!
    
    /// 用户签到
    @IBOutlet weak var signIn: UIView!
    
    
    // MARK: - 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 统一设置UI界面
        setupUI()
    }
}


// MARK: - 设置UI界面
extension AvatarView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 设置登录按钮的边框和背景颜色
        setupLoginBtn()
        
        // 设置签到控件的边框颜色
        setupSignView()
        
        
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
    }
    
    /// 设置按钮的边框和字体颜色
    fileprivate func setupLoginBtn() {
        
        // 设置边框颜色
        loginBtn.layer.borderColor = (UIColor.lightGray).cgColor
        
        // 设置边框粗细
        loginBtn.layer.borderWidth = 1.0
        
        // 设置按钮字体颜色
        loginBtn.setTitleColor(UIColor(r: 246, g: 91, b: 90), for: .normal)
        loginBtn.setTitleColor(.darkGray, for: .highlighted)
        
        // 设置按钮的圆角
        loginBtn.layer.cornerRadius = 3.0
        
        // 裁剪按钮
        loginBtn.clipsToBounds = true
    }
    
    /// 设置签到控件的边框
    fileprivate func setupSignView() {

        // 给按钮设置红色的边框
        signIn.layer.borderColor = (UIColor.red).cgColor
        
        // 设置边框的粗细
        signIn.layer.borderWidth = 1.0
    }
    
    
}


extension AvatarView {
    
    /// 监听登录按钮的点击
    @objc fileprivate func loginBtnClick() {
        
        // 这里需要拿到父控制器，然后present登录控制器
        print("AvatarView---loginBtnClick")
        
    }
}
