//
//  NavBarViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/22.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// http://recpage.c.qingting.fm/v3/navbar?wt=json&v=6.0.4&deviceid=093e8b7e24c02246fe92373727e4a92c&phonetype=iOS&osv=11.1.1&device=iPhone&pkg=com.Qting.QTTour

import UIKit

/// RequestURL
private let kRequestURL = "http://recpage.c.qingting.fm/v3/navbar"

class NavBarViewModel: NSObject {
    
    /// 用于存储转换完成的模型数据
    lazy var navBarModelArray = [NavBarModel]()
}


extension NavBarViewModel {
    
    
    /// 请求网络数据并将其转换为模型
    func requestData(completionHandler: @escaping () -> ()) {
        
        // 通过Alamofrie来发送网络请求
        NetworkTools.shareTools.requestData(kRequestURL, .get, parameters: ["wt": "json", "v": "6.0.4", "deviceid": "093e8b7e24c02246fe92373727e4a92c", "phonetype": "iOS", "osv": "11.1.1", "device": "iPhone", "pkg": "com.Qting.QTTour"]) { (result) in
            
            // 将JSON数据转成字典
            guard let resultDict = result as? [String: Any] else { return }
            
            // 根据字典中的关键字data取出字典中的数组数据
            guard let resultArray = resultDict["data"] as? [[String: Any]] else { return }
            
            // 遍历数组resultArray，取出它里面的字典
            for dict in resultArray {
                
                // 将字典转为模型
                let item = NavBarModel(dict: dict)
                
                // 将转换完成的模型存储起来
                self.navBarModelArray.append(item)
            }
            
            // 数据回调
            completionHandler()
        }
    }
}
