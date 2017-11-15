//
//  BoutiqueTableViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/15.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class BoutiqueTableViewCell: UITableViewCell {

    // MAKR: - 懒加载控件
    
    
    // MARK: - 构造函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension BoutiqueTableViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        //
    }
}
