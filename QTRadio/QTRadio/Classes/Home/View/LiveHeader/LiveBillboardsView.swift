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


/// BillBoard间距
private let kBillboardMargin: CGFloat = 15

/// 大咖榜的宽度
private let kImageWidth: CGFloat = 50


/// 大咖榜的高度
private let kImageHeight: CGFloat = 20


class LiveBillboardsView: UIView {
    
    // MARK: - 模型属性
    var billboardsModelArray: [LiveBillboardsModel]? {

        didSet {

            // 校验billboardsModelArray是否有值
            guard let billboardsModelArray = billboardsModelArray else { return }

            // 从数组billboardsModelArray中取出billItem模型
            let billItem = billboardsModelArray.first!

            // 取出模型数据
            for item in billItem.billboardsItemsModelArray {
                
                switch (item.title) {
                case "大咖榜":
                    // 设置大咖榜头像
                    leftAvatarView.leftIcon.setImage(item.userInfoModelArray[0].avatar)
                    leftAvatarView.centerIcon.setImage(item.userInfoModelArray[1].avatar)
                    leftAvatarView.rightIcon.setImage(item.userInfoModelArray[2].avatar)
                default:
                    // 设置贡献榜头像
                    rightAvatarView.leftIcon.setImage(item.userInfoModelArray[0].avatar)
                    rightAvatarView.centerIcon.setImage(item.userInfoModelArray[1].avatar)
                    rightAvatarView.rightIcon.setImage(item.userInfoModelArray[2].avatar)
                }
            }
        }
    }
    
    // MARK: - 私有属性
    
    /// 保存dotsView的高度
    fileprivate var billboardsViewHeight: CGFloat
    
    /// 头像控件的宽度
    fileprivate var avatarViewWidth: CGFloat = 0
    
    /// 头像控件的高度
    fileprivate var avatarViewHeight: CGFloat = 0
    
    
    
    // MARK: - 懒加载属性
    
    /// 左边的view
    lazy var leftView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: kMargin, width: (kScreenWidth - kMargin) * 0.5, height: billboardsViewHeight - 2 * kMargin))
        view.backgroundColor = .white
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftViewClick))
        view.addGestureRecognizer(tapGesture)
        
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
        
        // 添加点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rightViewClick))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    
    /// 大咖榜
    fileprivate lazy var daKaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "daka")
        return imageView
    }()
    
    
    /// 贡献榜
    fileprivate lazy var gongXianImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gongxian")
        return imageView
    }()
    
    
    /// 左边圆形图片控件
    lazy var leftAvatarView: LiveAvatarView = {
        
        avatarViewWidth = leftView.bounds.width - kImageWidth - 3 * kBillboardMargin
        avatarViewHeight = leftView.bounds.height - 2 * kMargin
        
        let view = LiveAvatarView(frame: CGRect(x: 0, y: 0, width: avatarViewWidth, height: avatarViewHeight))
        return view
    }()
    
    /// 右边圆形图片控件
    lazy var rightAvatarView: LiveAvatarView = {
        
        let view = LiveAvatarView(frame: CGRect(x: 0, y: 0, width: avatarViewWidth, height: avatarViewHeight))
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
        
        // 添加大咖榜
        leftView.addSubview(daKaImageView)
        
        // 添加贡献榜
        rightView.addSubview(gongXianImageView)
        
        // 添加左边的圆形头像
        leftView.addSubview(leftAvatarView)
        
        // 添加右边圆形头像
        rightView.addSubview(rightAvatarView)
    }
    
    /// 从新布局子空间呢
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局大咖榜
        daKaImageView.snp.makeConstraints { (make) in
            make.width.equalTo(kImageWidth)
            make.height.equalTo(kImageHeight)
            make.left.equalTo(self).offset(kBillboardMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局贡献榜
        gongXianImageView.snp.makeConstraints { (make) in
            make.width.equalTo(kImageWidth)
            make.height.equalTo(kImageHeight)
            make.left.equalTo(rightView.snp.left).offset(kBillboardMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局左边的圆形头像
        leftAvatarView.snp.makeConstraints { (make) in
            make.width.equalTo(avatarViewWidth)
            make.height.equalTo(avatarViewHeight)
            make.top.equalTo(leftView).offset(kMargin)
            make.left.equalTo(daKaImageView.snp.right).offset(kBillboardMargin)
        }
        
        // 布局右边的圆形头像
        rightAvatarView.snp.makeConstraints { (make) in
            make.width.equalTo(avatarViewWidth)
            make.height.equalTo(avatarViewHeight)
            make.top.equalTo(rightView).offset(kMargin)
            make.left.equalTo(gongXianImageView.snp.right).offset(kBillboardMargin)
        }
    }
}


// MARK: -
extension LiveBillboardsView {
    
    /// 点击大咖榜执行跳转
    @objc fileprivate func leftViewClick() {
        
        // 跳转到对应的控制器
        pushViewController()
    }
    
    
    /// 点击贡献榜执行跳转
    @objc fileprivate func rightViewClick() {
        
        // 跳转到对应的控制器
        pushViewController()
    }
    
    /// 执行push
    private func pushViewController() {
        
        // 取出tabBarVc
        guard let tabBarVc: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
        
        // 取出当前选中的导航控制器
        let nav: UINavigationController = (tabBarVc.selectedViewController as? UINavigationController)!
        
        // 创建控制器
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        
        // 通过当前选中的导航控制器push到下一个控制器
        nav.pushViewController(vc, animated: true)
    }
}
