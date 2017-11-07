//
//  ProfileHeader.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/6.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 顶部ProfileHeader的总高度
private let kProfileHeaderHeight: CGFloat = kScreenHeight * 0.3

/// 间距
private let kMargin: CGFloat = 5

/// avatarView的高度
private let kAvatarViewHeight: CGFloat = kProfileHeaderHeight * 0.4 - kMargin

class ProfileHeader: UIView {
    
    // MARK: - 懒加载属性
    
    /// 最上面的头像
    fileprivate lazy var avatarView: AvatarView = {
        
        let avatarView = AvatarView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kAvatarViewHeight))
        return avatarView
    }()
    
    /// 中间的profileView
    fileprivate lazy var profileView: ProfileView = {
        
        let profileView = ProfileView(frame: CGRect(x: 0, y: kAvatarViewHeight + kMargin, width: kScreenHeight, height: kProfileHeaderHeight - kAvatarViewHeight - 2 * kMargin))
        return profileView
    }()
    

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
