//
//  StarView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class StarView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 加载xib文件
        let stars = Bundle.main.loadNibNamed("StarView", owner: nil, options: nil)![0] as! StarView
        stars.frame = CGRect(x: 0, y: 0, width: 30, height: 10)
        addSubview(stars)
    }

}
