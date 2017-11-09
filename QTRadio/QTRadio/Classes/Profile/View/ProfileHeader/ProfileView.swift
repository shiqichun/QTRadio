//
//  ProfileView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/7.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用于展示"我的收藏", "我的下载", "我的主播"和"收听历史"这几个控件

import UIKit


class ProfileView: UIView {
    
    // MARK: - 懒加载属性
    
    /// 我的收藏
    fileprivate lazy var collect: ProfileCommonView = {
        
        let collectFrame = CGRect(x: 0, y: 0, width: frame.width / 2.0, height: frame.height * 0.5)
        let collect = ProfileCommonView(frame: collectFrame, imageName: "mine_collection_30x30_", title: "我的收藏", subtitle: "0")
        
        return collect
    }()
    
    /// 我的下载
    fileprivate lazy var download: ProfileCommonView = {
        
        let downloadFrame = CGRect(x: frame.width * 0.5, y: 0, width: frame.width * 0.5, height: frame.height * 0.5)
        let view = ProfileCommonView(frame: downloadFrame, imageName: "mine_download_30x30_", title: "我的下载", subtitle: "0")
        
        return view
    }()
    
    /// 我的主播 mine_podcaster_30x30_
    fileprivate lazy var anchor: ProfileCommonView = {
        
        let anchorFrame = CGRect(x: 0, y: frame.height * 0.5, width: frame.width * 0.5, height: frame.height * 0.5)
        let view = ProfileCommonView(frame: anchorFrame, imageName: "mine_podcaster_30x30_", title: "我的主播", subtitle: "登录后可同步")
        
        return view
    }()
    
    /// 收听历史 mine_rencently_30x30_
    fileprivate lazy var history: ProfileCommonView = {
        
        let historyFrame = CGRect(x: frame.width * 0.5, y: frame.height * 0.5, width: frame.width * 0.5, height: frame.height * 0.5)
        let view = ProfileCommonView(frame: historyFrame, imageName: "mine_rencently_30x30_", title: "收听历史", subtitle: "暂无记录")
        
        return view
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
    
    override func draw(_ rect: CGRect) {
        
        // 绘制直线
        drawStraightLine()
    }
    
    /// 绘制线条。"我的收藏", "我的下载"
    /// "我的主播", "收听历史"四个模块之
    /// 间的分割线
    private func drawStraightLine() {
        
        // 获取图形上下文
        guard let ctx: CGContext = UIGraphicsGetCurrentContext() else { return }
        
        // 创建路径对象
        let path: UIBezierPath = UIBezierPath()
        
        // 创建第一根线
        path.move(to: CGPoint(x: frame.width * 0.5, y: 0))  // 设置路径的起点
        path.addLine(to: CGPoint(x: frame.width * 0.5, y: frame.height))  // 设置路径的终点
        
        // 添加第二根线
        path.move(to: CGPoint(x: 0, y: frame.height * 0.5))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height * 0.5))
        
        // 将绘制的内容添加到上下文中
        ctx.addPath(path.cgPath)
        
        // 设置线宽
        ctx.setLineWidth(0.3)
        
        // 设置线条的颜色
        UIColor.lightGray.setStroke()
        
        // 将上下文中的内容显示到view控件上(即渲染到view的layer上，通常用stroke或者fill) */
        ctx.strokePath()
    }
}



// MARK: - 设置UI界面
extension ProfileView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {

        // 设置背景颜色
        backgroundColor = .white
        
        // 添加我的收藏
        addSubview(collect)
        
        // 添加我的下载
        addSubview(download)
        
        // 添加我的主播
        addSubview(anchor)
        
        // 添加收听历史
        addSubview(history)
        
        // 添加点击手势
        addTapGesture()
    }
    
    
    /// 添加手势
    private func addTapGesture() {
        
        // 给我的收藏添加点击手势
        let collectTapGesture = UITapGestureRecognizer(target: self, action: #selector(collectTap(_:)))
        collect.addGestureRecognizer(collectTapGesture)
        
        // 给我的下载添加手势
        let downloadTapGesture = UITapGestureRecognizer(target: self, action: #selector(downloadTap(_:)))
        download.addGestureRecognizer(downloadTapGesture)
        
        // 给我的主播添加手势
        let anchorTapGesture = UITapGestureRecognizer(target: self, action: #selector(anchorTap(_:)))
        anchor.addGestureRecognizer(anchorTapGesture)
        
        // 给收听历史添加手势
        let historyTapGesture = UITapGestureRecognizer(target: self, action: #selector(historyTap(_:)))
        history.addGestureRecognizer(historyTapGesture)
    }
}



// MARK: - 监听手势点击
extension ProfileView {
    
    /// push我的收藏控制器
    @objc fileprivate func collectTap(_ gesture: UITapGestureRecognizer) {
        
        // 取出tabBarVc
        guard let tabBarVc: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
        
        // 取出当前选中的导航控制器
        let nav: UINavigationController = (tabBarVc.selectedViewController as? UINavigationController)!
        
        // 创建我的收藏控制器，这里需要拦截导航控制器
        let vc = UIViewController() //FavoriteViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        
        // 通过当前选中的导航控制器push到下一个控制器
        nav.pushViewController(vc, animated: true)
    }
    
    /// push我的下载控制器
    @objc fileprivate func downloadTap(_ gesture: UITapGestureRecognizer) {
        
        // 取出tabBarVc
        guard let tabBarVc: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
        
        // 取出当前选中的导航控制器
        let nav: UINavigationController = (tabBarVc.selectedViewController as? UINavigationController)!
        
        // 创建控制器
        let vc = UIViewController()  // DownloadingViewController
        vc.view.backgroundColor = UIColor.randomColor()
        
        // 通过当前选中的导航控制器push到下一个控制器
        nav.pushViewController(vc, animated: true)
    }
    
    /// present登录控制器
    @objc fileprivate func anchorTap(_ gesture: UITapGestureRecognizer) {
        
        // 拿到根控制器
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        // 创建登录控制器
        let loginVc = LoginViewController()
        
        // 设置控制器的背景颜色(如果不设置背景颜色，modal动画很难看)
        loginVc.view.backgroundColor = .white
        
        // modal出控制器
        rootViewController.present(loginVc, animated: true, completion: nil)
    }
    
    /// push最近收听控制器
    @objc fileprivate func historyTap(_ gesture: UITapGestureRecognizer) {
        
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
