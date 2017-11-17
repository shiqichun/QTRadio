//
//  BoutiqueViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 精品内容数据
// http://api2.qingting.fm/v6/media/recommends/guides/section/1011?device_id=093e8b7e24c02246fe92373727e4a92c

// 播放次数
// http://i.qingting.fm/wapi/channel_playcount?cids=231638,231789,231341,,,,,205768,73958,,219773,224063,216713,222062,221748,226851,226839,230286,227575,199318,227810,207497,227594,225141,221748,227027,196502,207658,216133,199566,221146,226634,223378,194188,194928,192784,223905,210967,226522,219453,222352,205665,119466,208227,134436,220928,225815,204898,224195,223569,204554,221743,208447,215416&wt=json&v=6.0.4&deviceid=093e8b7e24c02246fe92373727e4a92c&phonetype=iOS&osv=11.1.1&device=iPhone&pkg=com.Qting.QTTour


import UIKit

/// URL地址
private let kRequestURL = "http://api2.qingting.fm/v6/media/recommends/guides/section/1011"

/// device_id
private let kDeviceId = "093e8b7e24c02246fe92373727e4a92c"

/// 播放次数的URL地址
private let kPlayRequestURL = "http://i.qingting.fm/wapi/channel_playcount"


private let kCids = "231638,231789,231341,,,,,205768,73958,,219773,224063,216713,222062,221748,226851,226839,230286,227575,199318,227810,207497,227594,225141,221748,227027,196502,207658,216133,199566,221146,226634,223378,194188,194928,192784,223905,210967,226522,219453,222352,205665,119466,208227,134436,220928,225815,204898,224195,223569,204554,221743,208447,215416"






class BoutiqueViewModel: NSObject {
    
    // MARK: - 字典数组
    
    /// Banner的数据
    fileprivate lazy var bannerArray = [[String: Any]]()
    
    
    // MARK: - 模型数组
    
    /// 用于存储Banner的模型
    lazy var bannerModelArray: [BoutiqueBannerModel] = [BoutiqueBannerModel]()
    
    /// 用于存储TableView的模型
    lazy var tableModelArray: [BoutiqueTableModel] = [BoutiqueTableModel]()
    
    /// 用于存储playCountModel
    lazy var playCountModelArray: [BoutiquePlayCountModel] = [BoutiquePlayCountModel]()
}




// MARK: - 发送网络请求
extension BoutiqueViewModel {
    
    
    /// 请求网络数据，并且将其转为模型
    func requestData(completionHandler: @escaping () -> ()) {
        
        
        // 创建组
        let group = DispatchGroup()
        
        
        
        
        // 进组
        group.enter()
        
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
            
            // 离开组
            group.leave()
        }
        
        
        
        
        
        
        // 进组
        group.enter()
        
        // 请求播放次数的数据
        NetworkTools.shareTools.requestData(kPlayRequestURL, .get, parameters: ["cids": kCids, "wt": "json", "v": "6.0.4", "deviceid": kDeviceId, "phonetype": "iOS", "osv": "11.1.1", "device": "iPhone", "pkg": "com.Qting.QTTour"]) { (playResult) in
            
            // 将数据转为字典
            guard let playResultDict = playResult as? [String: Any] else { return }
            
            // 根据字典中的键data取出与之对应的数据
            guard let playResultArray = playResultDict["data"] as? [[String: Any]] else { return }
            
            // 遍历数组playResultArray中的字典
            for dict in playResultArray {
                
                // 将字典转为模型
                let playItem = BoutiquePlayCountModel(dict: dict)
                
                // 将转换完成的模型数据保存起来
                self.playCountModelArray.append(playItem)
            }
            
            // 离开组
            group.leave()
        }
        
        
        
        
        
        // 所有数据请求完成以后，在进行回调
        group.notify(queue: DispatchQueue.main) {
            
            // 回调
            completionHandler()
        }
    }
}
