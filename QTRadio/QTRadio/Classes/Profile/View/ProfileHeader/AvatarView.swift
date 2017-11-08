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
        
        // 监听登录按钮的点击
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
        // signIn控件添加手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTap(_:)))
        signIn.addGestureRecognizer(tapGesture)
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



// MARK: - 监听事件的点击
extension AvatarView {
    
    /// 监听登录按钮的点击
    @objc fileprivate func loginBtnClick() {
        
        // 这里需要拿到父控制器，然后present登录控制器
        // 拿到根控制器
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        // 创建登录控制器
        let loginVc = LoginViewController()
        
        // 设置控制器的背景颜色(如果不设置背景颜色，modal动画很难看)
        loginVc.view.backgroundColor = .white
        
        // modal出控制器
        rootViewController.present(loginVc, animated: true, completion: nil)
        
    }
    
    @objc fileprivate func signInTap(_ tapGesture: UITapGestureRecognizer) {
        
        // 取出tabBarVc
        guard let tabBarVc: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
        
        // 取出当前选中的导航控制器
        let nav: UINavigationController = (tabBarVc.selectedViewController as? UINavigationController)!
        
        // 创建控制器
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.brown
        
        // 通过当前选中的导航控制器push到下一个控制器
        nav.pushViewController(vc, animated: true)
    }
}
