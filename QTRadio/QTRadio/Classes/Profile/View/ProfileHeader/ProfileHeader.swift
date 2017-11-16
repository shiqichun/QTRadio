//
//  ProfileHeader.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/6.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 间距
private let kMargin: CGFloat = 5

class ProfileHeader: UIView {
    
    // MARK: - 私有属性
    
    /// 父控制器
    fileprivate var parentVc: UIViewController
    
    /// profileHeaderHeight
    fileprivate var profileHeaderHeight: CGFloat
    
    
    // MARK: - 懒加载属性
    
    /// 最上面的头像
    fileprivate lazy var avatarView: AvatarView = {
        
        // 从xib中加载avatarView
        let avatarView = Bundle.main.loadNibNamed("AvatarView", owner: nil, options: nil)?[0] as! AvatarView
        
        // 设置avatarView的frame
        avatarView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: profileHeaderHeight * 0.45)
        
        return avatarView
    }()
    
    /// 中间的profileView
    fileprivate lazy var profileView: ProfileView = {
        
        // 从xib中加载profileView
        let profileView = ProfileView(frame: CGRect(x: 0, y: profileHeaderHeight * 0.45 + kMargin, width: kScreenWidth, height: profileHeaderHeight - (profileHeaderHeight * 0.45 + kMargin)))
        
        return profileView
    }()
    

    
    // MARK: - 自定义的构造函数
    
    /// 自定义构造函数，方便根据实际需要创建控件
    /// - 参数frame：表示控件的frame
    /// - 参数parentVc：表示控件的父控制器
    init(frame: CGRect, parentVc: UIViewController) {
        
        // 初始化私有属性
        self.parentVc = parentVc
        self.profileHeaderHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



// MARK: - 设置UI界面
extension ProfileHeader {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置ProfileHeader的背景颜色
        backgroundColor = UIColor(r: 239, g: 239, b: 244)
        
        // 添加avatarView
        addSubview(avatarView)
        
        // 添加profileView
        addSubview(profileView)
    }
}
