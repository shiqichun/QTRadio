//
//  AppDelegate.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// backgroundColor = UIColor(r: 245, g: 244, b: 249)

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置tabBar子控制器标题的颜色
        UITabBar.appearance().tintColor = UIColor(r: 252, g: 93, b: 96)
        
        // 去掉导航栏底部的分割线
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //设置navigationBar的背景颜色
        UINavigationBar.appearance().barTintColor = UIColor(r: 246, g: 246, b: 246)
        
        
        // 设置窗口的frame
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 设置窗口的根控制器
        window?.rootViewController = MainViewController()
        window?.backgroundColor = .white
        // 显示窗口
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    /// 如果想同时修改导航栏的背景颜色和标题等
    /// 颜色，可以通过下面这种方式来进行修改
    private func setupNavigationBar() {
        
        let bar: UINavigationBar = UINavigationBar.appearance()
        
        //设置navigationBar的背景颜色
        bar.barTintColor = UIColor(r: 246, g: 246, b: 246)
        
        // 设置字体的颜色
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
    }

}

