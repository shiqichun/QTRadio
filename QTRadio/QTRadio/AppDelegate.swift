//
//  AppDelegate.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 设置tabBar子控制器标题的颜色
        UITabBar.appearance().tintColor = UIColor(r: 252, g: 93, b: 96)
        
        
        // 设置窗口的frame
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 设置窗口的根控制器
        window?.rootViewController = MainViewController()
        window?.backgroundColor = .white
        // 显示窗口
        window?.makeKeyAndVisible()
        
        return true
    }

}

