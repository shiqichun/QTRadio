//
//  RecommendViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 导航栏数据
// http://recpage.c.qingting.fm/v3/navbar?wt=json&v=6.0.4&deviceid=093e8b7e24c02246fe92373727e4a92c&phonetype=iOS&osv=11.1.1&device=iPhone&pkg=com.Qting.QTTour

// 推荐界面数据
// http://recpage.c.qingting.fm/v3/hotpage?phonetype=iOS&sex=male&region=23&deviceid=093e8b7e24c02246fe92373727e4a92c&gen=80
// http://recpage.c.qingting.fm/v3/hotpage?phonetype=iOS&sex=male&region=23&deviceid=093e8b7e24c02246fe92373727e4a92c&gen=80

// 推荐界面刷新数据
// http://recpage.c.qingting.fm/v3/hotpage?phonetype=iOS&sex=male&region=23&deviceid=093e8b7e24c02246fe92373727e4a92c&gen=80
// http://recpage.c.qingting.fm/v3/hotpage?phonetype=iOS&sex=male&region=23&deviceid=093e8b7e24c02246fe92373727e4a92c&gen=80





// 位置界面数据
// http://api2.qingting.fm/v6/media/recommends/guides/section/p/0/section/732/banner/0/other/5/page/5

// 搜索框关键字
// http://i.qingting.fm/capi/search/keywords


// 广告数据
// http://bdsp.x.jd.com/adx/dragonfly









import UIKit

/// 网络数据请求地址
private let kRequestURL = "http://recpage.c.qingting.fm/v3/hotpage"

/// deviceid
private let kDeviceid = "093e8b7e24c02246fe92373727e4a92c"

class RecommendViewModel: NSObject {
    
    
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
                    
                    // 将字典转为模型
                    let bannerItem = BannerModel(dict: dict)
                    
                    // 将转换完成的模型存储到模型数组中
                    self.bannerModelArray.append(bannerItem)
                    
                    
                case "IconGrid":
                    
                    // 将字典转为模型
                    let iconGridItem = IconGridModel(dict: dict)
                    
                    // 将转换完成的模型存储到模型数组中
                    self.iconGridModelArray.append(iconGridItem)
                    
                case "HotWordGrid":
                    
                    // 将字典转为模型
                    let hotWordGridItem = HotWordGridModel(dict: dict)
                    
                    // 将转换完成的模型数组存储到数组中
                    self.hotWordGridModelArray.append(hotWordGridItem)
                    
                case "Recommend":
                    
                    // 将字典转为模型
                    let recommendItem = RecommendModel(dict: dict)
                    
                    // 将转换完成的模型存储到模型数组中
                    self.recommendModelArray.append(recommendItem)
                    
                default:
                    
                    // 将字典转为模型
                    let liveShowItem = LiveShowModel(dict: dict)
                    
                    // 将转换完成的模型存储到模型数组中
                    self.liveShowModelArray.append(liveShowItem)
                }
            }
            
            // 数据处理完毕，将其回调给外界
            completionHandler()
        }
    }
}
