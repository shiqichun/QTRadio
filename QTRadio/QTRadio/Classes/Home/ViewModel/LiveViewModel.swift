//
//  LiveViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

// 直播的top数据，前三个依次为Banner、热门分类、大咖榜和贡献榜
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=HTTP/1.1

// 房间数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=

// 热门儿房间数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=HTTP/1.1

// 新秀房间数据
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

class LiveViewModel: NSObject {

}


// MARK: - 发送网路请求
extension LiveViewModel {
    
    /// 请求网络数据的方法
    func requestData(completionHander: @escaping () -> ()) {
        
        // 请求topView(也就是Banner、热门分类、大咖榜和贡献榜)的数据
        
        
        
        
        // 请求热门数据
        
        
        
        
        // 请求新秀数据
        
        
        
        
        // 数据回调
        completionHander()
    }
}
