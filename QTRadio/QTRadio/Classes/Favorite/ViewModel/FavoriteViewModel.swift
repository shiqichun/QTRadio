//
//  FavoriteViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/4.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 负责收藏模块网络请求的功能
// http://rec.c.qingting.fm/v1/recommend/collection?deviceid=093e8b7e24c02246fe92373727e4a92c&pageSize=20

import UIKit


/// 请求地址
private let kRequestURL = "http://rec.c.qingting.fm/v1/recommend/collection"

/// deviceid参数
private let kDeviceid = "093e8b7e24c02246fe92373727e4a92c"




class FavoriteViewModel {
    
    /// 用于存放已经转换完成的模型数据
    lazy var albumArr: [AlbumModel] = [AlbumModel]()

}


// MARK: - 发送网络请求
extension FavoriteViewModel {
    
    /// 请求收藏模块中主控制器的网络数据
    func requestData(completionHandler: @escaping () -> ()) {
        
        // 发送网络请求
        NetworkTools.shareTools.requestData(kRequestURL, .get, parameters: ["deviceid": kDeviceid, "pageSize": "9"]) { (result) in
            
            // 将JSON数据转成字典
            guard let resultDict = result as? [String: Any] else { return }

            // 根据键data取出字典resultDict中的数据，然后再将其转成成字典数组(即，数组中存放的是字典)
            guard let resultArr = resultDict["data"] as? [[String: Any]] else { return }

            // 遍历数组resultArr中的字典数据，然后再将其转为模型
            for dict in resultArr {

                // 将字典传入模型AlbumModel进行转换
                let album = AlbumModel(dict: dict)

                // 将转换完成的模型存入数组
                self.albumArr.append(album)
            }

            // 模型转换完成以后，需要将其回调出去
            completionHandler()
        }
    }
}
