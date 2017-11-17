//
//  LiveViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 网页数据
// https://m.zhibo.qingting.fm

// 直播的top数据，前三个依次为Banner、热门分类、大咖榜和贡献榜(GET)
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=HTTP/1.1

// 房间数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=

// 热门儿房间数据(GET)
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=HTTP/1.1
// 热门上啦刷新数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=2&page_size=20&room_ids=&partner=&ptnp=

// 新秀房间数据(GET)
// https://api.zhibo.qingting.fm/v2/recommends/sections/13/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=




// 倾向于用这一个
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=HTTP/1.1

// 上拉刷新数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=2&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=3&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=4&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=5&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=6&page_size=20&room_ids=&partner=&ptnp=


// 直播数据
// http://api.zhibo.qingting.fm/v2/recommends/sections/14/random_items?wt=json&v=6.0.4&deviceid=093e8b7e24c02246fe92373727e4a92c&phonetype=iOS&osv=11.1.1&device=iPhone&pkg=com.Qting.QTTour

import UIKit


/// 热门数据请求地址
private let kHotRequestURL = "https://api.zhibo.qingting.fm/v2/recommends/sections/12/items"


class LiveViewModel: NSObject {
    
    // MARK: - 模型数组
    
    /// 用于存储转换完成的热门模型
    lazy var hotModelArray: [LiveHotModel] = [LiveHotModel]()

}


// MARK: - 发送网路请求
extension LiveViewModel {
    
    /// 请求网络数据的方法
    func requestData(completionHander: @escaping () -> ()) {
        
        // 请求topView(也就是Banner、热门分类、大咖榜和贡献榜)的数据
        
        
        
        
        // 请求热门数据
        NetworkTools.shareTools.requestData(kHotRequestURL, .get, parameters: ["page_num": "1", "page_size": "20", "room_ids": "", "partner": "", "ptnp": "HTTP/1.1"]) { (result) in
            
            // 将数据转为字典
            guard let resultDict = result as? [String: Any] else { return }

            // 根据字典中的键ret取出与之对应的数据
            guard let retDict = resultDict["ret"] as? [String: Any] else { return }
            
            // 再根据retDict这个字典中的键items，取出与之对应的数组数据
            guard let resultArray = retDict["items"] as? [[String: Any]] else { return }
            
            // 遍历数组resultArray，取出它里面的字典
            for dict in resultArray {
                
                // 将字典转为模型
                let hotItem = LiveHotModel(dict: dict)

                // 将转换完成的热门模型存储起来
                self.hotModelArray.append(hotItem)
            }
            
            completionHander()
        }
        
        
        // 请求新秀数据
        
        
        
        // 上拉刷新的数据
        
        
        // 数据回调
        
    }
}
