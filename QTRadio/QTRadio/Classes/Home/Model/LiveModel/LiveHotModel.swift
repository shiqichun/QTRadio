//
//  LiveHotModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 直播界面热门数据的Model

import UIKit



@objcMembers
class LiveHotModel: NSObject {
    
    // MARK: - 模型数组
    
    /// 将转换完成的current字典模型存储起来
    lazy var currentModelArray: [LiveCurrentModel] = [LiveCurrentModel]()
    
    
    // MARK: - 服务器返回的模型属性
    
    /// id
    var id: Int = 0
    
    /// cell的配图地址
    var cover: String = ""
    
    /// user_id
    var user_id: String = ""
    
    /// nick_name(配图下面第一行左边的文字)
    var nick_name: String = ""
    
    /// room_name(房间名称，在一级界面不显示)
    var room_name: String = ""
    
    /// room_status(1表示预约直播，2表示正在直播)
    var room_status: Int = 2
    
    /// online_user(在线收听人数)
    var online_user: Int = 0

    /// current(当前的直播信息)
    var current: [String: Any]? {
        
        didSet {
            
            // 首先校验字典current里面有没有值
            guard let current = current else { return }
            
            // 直接将字典current转换为模型
            let item = LiveCurrentModel(dict: current)
            
            // 将转换完成的模型数据保存起来
            currentModelArray.append(item)
        }
    }
    
    /// liveshow_url
    var liveshow_url: String = ""
    
    /// last_week_rank(就是配图上显示的大咖等级)
    /// 这是一个奇葩，等级应该是Int的，但是它又可能
    /// 为空，所以不管是用Int还是String，它都会导致
    /// 程序崩溃，所以干脆给它搞一个Any算了
    var last_week_rank: Any?
    
    /// tag(配图下面第一行右边#标签)
    var tag: String = ""
    
    /// is_pinned(是否显示hot图标)
    var is_pinned: Bool = false
    
    
    
    
    // MARK: - 自定义构造函数
    
    /// 将字典转为模型
    init(dict: [String: Any]) {
        super.init()
        
        // 利用KVC将字典转为模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
