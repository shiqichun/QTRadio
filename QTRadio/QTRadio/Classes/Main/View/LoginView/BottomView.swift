//
//  BottomView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/3.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 主要是用来管理底部第三方账号注册和登录的圆形按钮

import UIKit

/// 第三方登录按钮之间的间距
private let kButtonMargin: CGFloat = 30

/// 第三方登录按钮距离顶部标题的间距
private let kTopMargin: CGFloat = kScreenHeight * 70.0 / 667.0

/// 第三方登录按钮的宽度
private let kLoginButtonWidth: CGFloat = (kScreenWidth - 5 * kButtonMargin) / 4

/// 第三方登录按钮文本控件的宽度
private let kLoginTitleLabelHeight: CGFloat = 30

/// 第三方登录按钮的frame
private let kBtnFrame: CGRect = CGRect(x: 0, y: 0, width: kLoginButtonWidth, height: kLoginButtonWidth + kLoginTitleLabelHeight)

class BottomView: UIView {

    // MARK: - 私有属性
    
    /// 保存父控制器
    fileprivate var parentVc: UIViewController
    
    
    // MARK: - 懒加载属性
    
    /// 标题控件
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "— 第三方账号注册/登录 —"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    /// 微信
    fileprivate lazy var weixinBtn: UIButton = {
        
        let btn = SNSButton(frame: kBtnFrame, imageName: "weiXinFriend_52x52_", hightlightImageName: "weiXinFriendPress_52x52_", title: "微信")
        
        btn.addTarget(self, action: #selector(weixinBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    /// 微博
    fileprivate lazy var weiboBtn: UIButton = {
        
        let btn = SNSButton(frame: kBtnFrame, imageName: "sinaWeiBo_53x52_", hightlightImageName: "sinaWeiBoPress_53x52_", title: "微博")
        
        btn.addTarget(self, action: #selector(weiboBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    /// QQ
    fileprivate lazy var qqBtn: UIButton = {
        
        
        let btn = SNSButton(frame: kBtnFrame, imageName: "qqFriend_52x52_", hightlightImageName: "qqFriendPress_52x52_", title: "QQ")
        
        btn.addTarget(self, action: #selector(qqBtnClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    
    /// 更多账户
    fileprivate lazy var moreBtn: UIButton = {
        
        let btn = SNSButton(frame: kBtnFrame, imageName: "sns_more_52x52_", title: "更多账户")
        
        btn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        
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
extension BottomView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加标题控件
        addSubview(titleLabel)
        
        // 添加微信按钮
        addSubview(weixinBtn)
        
        // 添加微博按钮
        addSubview(weiboBtn)
        
        // 添加QQ按钮
        addSubview(qqBtn)
        
        // 添加更多按钮
        addSubview(moreBtn)
    }
    
    
    // 重新布局所有的子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局标题控件的位置
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        
        // 布局微信按钮的位置
        weixinBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kTopMargin)
            make.left.equalTo(self).offset(kButtonMargin)
        }
        
        // 布局微博按钮的位置
        weiboBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kTopMargin)
            make.left.equalTo(weixinBtn.snp.right).offset(kButtonMargin)
        }
        
        // 布局QQ按钮的位置
        qqBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kTopMargin)
            make.left.equalTo(weiboBtn.snp.right).offset(kButtonMargin)
        }
        
        // 布局更多按钮的位置
        moreBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kTopMargin)
            make.left.equalTo(qqBtn.snp.right).offset(kButtonMargin)
        }
    }
}




// MARK: - 监听事件的点击
extension BottomView {
    
    /// 监听微信按钮的点击
    @objc fileprivate func weixinBtnClick() {
        
        print("Bottom---weixinBtnClick")
    }
    
    /// 监听微博按钮的点击
    @objc fileprivate func weiboBtnClick() {
        
        print("Bottom---weiboBtnClick")
    }
    
    /// 监听QQ按钮的点击
    @objc fileprivate func qqBtnClick() {
        
        print("Bottom---qqBtnClick")
    }
    
    /// 监听更多账户按钮的点击
    @objc fileprivate func moreBtnClick() {
        
        print("Bottom---moreBtnClick")
    }
}

