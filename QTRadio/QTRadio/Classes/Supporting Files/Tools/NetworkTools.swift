//
//  NetworkTools.swift
//  请求网络数据
//
//  Created by Enrica on 2017/11/4.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import Alamofire


/// 定义请求方式
enum MethodType {
    case get
    case post
}

class NetworkTools {
    static let shareTools: NetworkTools = {
        let tools = NetworkTools()
        return tools
    }()
}

extension NetworkTools {
    
    /// 发送网络请求并获取结果
    /// - 参数URLString：表示网络请求地址
    /// - 参数methodType：表示请求类型，get请求或者post请求
    /// - 参数parameters：表示请求参数。如果是get请求，可以不传；如果是post请求，按照实际情况传递
    /// - 参数completionHandler：回调参数，将请求结果传递到外面
    func requestData(_ URLString: String, _ methodType: MethodType, parameters: [String: String]? = nil, completionHandler: @escaping (_ result: Any) -> ()) {
        
        // 获取网络请求类型
        let method = methodType == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 对请求结果进行校验
            guard let result = response.result.value else {
                
                // 打印错误信息
                print(response.result.error!)
                
                return
            }
            
            // 将请求结果回调出去
            completionHandler(result)
        }
    }
}
