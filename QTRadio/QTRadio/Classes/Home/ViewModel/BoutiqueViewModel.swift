//
//  BoutiqueViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 精品内容数据
// http://api2.qingting.fm/v6/media/recommends/guides/section/1011?device_id=093e8b7e24c02246fe92373727e4a92c

import UIKit

/// URL地址
private let kRequestURL = "http://api2.qingting.fm/v6/media/recommends/guides/section/1011"

/// device_id
private let kDeviceId = "093e8b7e24c02246fe92373727e4a92c"

class BoutiqueViewModel: NSObject {
    
    // MARK: - 字典数组
    
    /// Banner的数据
    fileprivate lazy var bannerArray = [[String: Any]]()
    
    
    // MARK: - 模型数组
    
    /// 用于存储Banner的模型
    lazy var bannerModelArray: [BoutiqueBannerModel] = [BoutiqueBannerModel]()
    
    /// 用于存储TableView的模型
    lazy var tableModelArray: [BoutiqueTableModel] = [BoutiqueTableModel]()
}




// MARK: - 发送网络请求
extension BoutiqueViewModel {
    
    /// 请求网络数据，并且将其转为模型
    func requestData(completionHandler: @escaping () -> ()) {
        
        // 发送网络请求
        NetworkTools.shareTools.requestData(kRequestURL, .get, parameters: ["device_id": kDeviceId]) { (result) in
            
            // 将数据转为字典
            guard let resultDict = result as? [String: Any] else { return }
            
            // 再根据字典中的键data取出与之对应的数据，其类型为一个数组，并且数组中装着字典
            guard let resultArray = resultDict["data"] as? [[String: Any]] else { return }
            
            // 将数组中的第一个字典，也就是Banner数据提出来单独存储
            self.bannerArray.append(resultArray.first!)
            
            // 将bannerArray中的字典转为模型
            let bannerItem = BoutiqueBannerModel(dict: self.bannerArray.first!)
            
            // 将Banner模型存储起来
            self.bannerModelArray.append(bannerItem)
            
            
            // 遍历resultArray中除第0个之外所有的字典
            for dict in resultArray.dropFirst() {
                
                // 将字典转为模型
                let tableItem = BoutiqueTableModel(dict: dict)
                
                // 将转换完成的模型存储到数组中
                self.tableModelArray.append(tableItem)
            }
            
            
            // 将转换完成的数据进行回调
            completionHandler()
        }
    }
}
