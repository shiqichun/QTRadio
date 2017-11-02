//
//  WhiteImage.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/2.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 因为项目中很多地方都要设置白色的背景，但是单纯的设置背景颜色为
// 白色，最后还是显得不够白，所以我就用了一张非常白的图片作为背景

import UIKit


class WhiteImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 设置UI界面
extension WhiteImage {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 加载一张白色图片  minibar_myfavorite_highlight_30x30_   backgroundImage
        guard let whiteImage = UIImage(named: "backgroundImage") else { return }
        
        // 图片的宽度
        let imageWidth: CGFloat = whiteImage.size.width
        
        // 图片的高度
        let imageHeight: CGFloat = whiteImage.size.height
        
        // 设置图片受保护的区域
        let stretchImage = whiteImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageHeight * 0.5, left: imageWidth * 0.5, bottom: imageHeight * 0.5 - 1, right: imageWidth * 0.5 - 1))
        
        // 将受保护的拉伸图片设置到imageView上面去
        image = stretchImage
    }
}
