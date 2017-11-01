//
//  DownloadedViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class DownloadedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension DownloadedViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        //
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
    }
}
