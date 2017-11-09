//
//  CategoryBottomView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/9.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class CategoryBottomView: UIView {

    // MARK: - 懒加载属性
    
    /// 广播电台
    fileprivate lazy var broadcastView: UIView = {
        
        let broadFrame = CGRect(x: 0, y: 0, width: kScreenWidth * 0.5, height: frame.size.height)
        let broadcastView = ItemView(frame: broadFrame, imageName: "广播电台", title: "广播电台")
        return broadcastView
    }()
    
    /// 直播专区
    fileprivate lazy var liveView: UIView = {
        
        let liveFrame = CGRect(x: kScreenWidth * 0.5, y: 0, width: kScreenWidth * 0.5, height: frame.size.height)
        let liveView = ItemView(frame: liveFrame, imageName: "直播专区", title: "直播专区")
        return liveView
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
extension CategoryBottomView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加广播电台
        addSubview(broadcastView)
        
        // 给广播电台添加手势
        let broadcastTap = UITapGestureRecognizer(target: self, action: #selector(broadcastViewTap(_:)))
        broadcastView.addGestureRecognizer(broadcastTap)
        
        // 添加直播专区
        addSubview(liveView)
        
        // 给直播专区添加手势
        let liveTap = UITapGestureRecognizer(target: self, action: #selector(liveViewTap(_:)))
        liveView.addGestureRecognizer(liveTap)
    }
}



// MARK: - 监听事件的点击
extension CategoryBottomView {
    
    /// 监听广播电台的点击
    @objc fileprivate func broadcastViewTap(_ gesture: UIGestureRecognizer) {
        
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
    
    
    /// 监听直播专区的点击
    @objc fileprivate func liveViewTap(_ gesture: UIGestureRecognizer) {
        
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
