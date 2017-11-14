//
//  RecommendViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// http://recpage.c.qingting.fm/v3/hotpage?phonetype=iOS&sex=male&region=23&deviceid=093e8b7e24c02246fe92373727e4a92c&gen=80

import UIKit

/// 网络数据请求地址
private let kRequestURL = "http://recpage.c.qingting.fm/v3/hotpage"

///
private let kDeviceid = "093e8b7e24c02246fe92373727e4a92c"

class RecommendViewModel: NSObject {
    
    // MARK: - 字典数组
    
    /// 存储Banner字典
    fileprivate lazy var bannerArray: [[String: Any]] = [[String: Any]]()
    
    /// 存储IconGrid字典
    fileprivate lazy var iconGridArray: [[String: Any]] = [[String: Any]]()
    
    /// 存储HotWordGrid字典
    fileprivate lazy var hotWordGridArray: [[String: Any]] = [[String: Any]]()
    
    /// 存储Recommend字典
    fileprivate lazy var recommendArray: [[String: Any]] = [[String: Any]]()
    
    /// 存储LiveShow字典
    fileprivate lazy var liveShowArray: [[String: Any]] = [[String: Any]]()
    
    
    // MARK: - 模型数组
    
    /// bannerModel，用于存储转换完成的BannerModel模型
    lazy var bannerModelArray: [BannerModel] = [BannerModel]()
    
    /// iconGridModel，用于存储转换完成的IconGridModel模型
    lazy var iconGridModelArray: [IconGridModel] = [IconGridModel]()
    
    /// hotWordGridModel，用于存储转换完成的HotWordGridModel模型
    lazy var hotWordGridModelArray: [HotWordGridModel] = [HotWordGridModel]()
    
    /// recommendModel，用于存储转换完成的RecommendModel模型(33个数据)
    lazy var recommendModelArray: [RecommendModel] = [RecommendModel]()
    
    /// liveShowModel，用于存储转换完成的LiveShowModel模型
    lazy var liveShowModelArray: [LiveShowModel] = [LiveShowModel]()
    
}



// MARK: - 发送网路请求
extension RecommendViewModel {
    
    /// 请求收藏模块中主控制器的网络数据
    func requestData(completionHandler: @escaping () -> ()) {
        
        // 发送网络请求
        NetworkTools.shareTools.requestData(kRequestURL, .get, parameters: ["phonetype": "iOS", "sex": "male", "region": "23", "deviceid": kDeviceid, "gen": "80"]) { (result) in
            
            // 现将JSON数据转成字典
            guard let resutltDict = result as? [String: Any] else { return }
            
            // 再根据字典中的键data取出与之对应的值，其结果仍然为一个字典
            guard let dataDict = resutltDict["data"] as? [String: Any] else { return }
            
            // 再根据字典中的键modules取出与之对应的值，其结果为一个数组，而数组中存储的又是字典
            guard let modulesArray = dataDict["modules"] as? [[String: Any]] else { return }
            
            // 遍历数组modulesArray，取出它里面的字典
            for dict in modulesArray {
                
                // 将不同模块的字典数据存储到不同的数组中
                switch (dict["type"] as! String) {
                    
                case "Banner":
                    
                    // 将Banner模块的字典数据存储到bannerArray
                    self.bannerArray.append(dict)
                    
                case "IconGrid":
                    
                    // 将IconGrid模块的字典数据存储到iconGridArray
                    self.iconGridArray.append(dict)
                    
                case "HotWordGrid":
                    
                    // 将HotWordGrid模块的字典数据存储到hotWordGridArray
                    self.hotWordGridArray.append(dict)
                    
                case "Recommend":
                    
                    // 将Recommend模块的字典数据存储到recommendArray
                    self.recommendArray.append(dict)
                    
                default:
                    
                    // 将LiveShow模块的字典数据存储到liveShowArray
                    self.liveShowArray.append(dict)
                }
            }
            
            // 取出bannerArray中的字典，然后将其转为模型
            for bannerDict in self.bannerArray {
                
                // 将字典转为模型
                let bannerItem = BannerModel(dict: bannerDict)
                
                // 将转换完成的模型存储到模型数组中
                self.bannerModelArray.append(bannerItem)
            }
            
            
            // 取出iconGridArray中的字典，然后再将其转为模型
            for iconGridDict in self.iconGridArray {
                
                // 将字典转为模型
                let iconGridItem = IconGridModel(dict: iconGridDict)
                
                // 将转换完成的模型存储到模型数组中
                self.iconGridModelArray.append(iconGridItem)
            }
            
            
            // FIXME: - 这个字典转模型性的数据居然是空的
            // 取出hotWordGridArray中的字典，然后再将其转为模型
            for hotWordGridDict in self.hotWordGridArray {
                
                // 将字典转为模型
                let hotWordGridItem = HotWordGridModel(dict: hotWordGridDict)
                
                // 将转换完成的模型数组存储到数组中
                self.hotWordGridModelArray.append(hotWordGridItem)
            }
            
            // 取出recommendArray中的字典，然后再将其转为模型
            for recommendDict in self.recommendArray {
                
                // 将字典转为模型
                let recommendItem = RecommendModel(dict: recommendDict)
                
                // 将转换完成的模型存储到模型数组中
                self.recommendModelArray.append(recommendItem)
            }
            
            
            // 取出liveShowArray中的字典，然后再将其转为模型
            for liveShowDict in self.liveShowArray {
                
                // 利用KVC将字典转为模型
                let liveShowItem = LiveShowModel(dict: liveShowDict)
                
                // 将转换完成的模型存储到模型数组中
                self.liveShowModelArray.append(liveShowItem)
            }
            
            // 回调
            completionHandler()
            
//            for item in self.recommendModelArray {
//                for it in item.recommendDataModelArray {
//                    print(it.data?.count)
//                }
//            }
        }
    }
}
