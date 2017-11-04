//
//  FavoriteViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/4.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 负责收藏模块网络请求的功能

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
            
            // 将请求结果转成数组
            guard let resultArr = result as? [String: Any] else { return }

            // 通过data这个键从数组resultArr中取出字典
            guard let resultDict = resultArr["data"] as? [[String: Any]] else { return }

            // 遍历字典，利用KVC将其转为模型
            for dict in resultDict {

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
