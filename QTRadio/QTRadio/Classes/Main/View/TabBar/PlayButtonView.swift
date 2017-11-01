//
//  PlayButtonView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class PlayButtonView: UIView {

    // MARK: - 保存私有属性
    
    /// 父控制器
    fileprivate var parentVc: UIViewController
    
    
    
    // MARK: - 懒加载属性
    
    
    /// tabbar_np_normal
    fileprivate lazy var imageView: UIImageView = {
        
        // 创建imageView
        let imageView = UIImageView()
        
        // 设置normalImageView的图片
        imageView.image = UIImage(named: "tabbar_np_normal")  // tabbar_np_normal
        
        // 设置imageView的尺寸
        imageView.sizeToFit()
        
        // 开启imageView的手势交互
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    /// 中间的播放按钮
        fileprivate lazy var playButton: UIButton = {
    
            // 创建按钮
            let playButton = UIButton(image: "play_page_control_bar_play_48x48_", highlightedImage: "play_page_control_bar_play_disabled_48x48_")
    
            // 监听中间播放按钮的点击
            playButton.addTarget(self, action: #selector(PlayButtonView.playButtonClick), for: .touchUpInside)
    
            return playButton
        }()
    
    
    // MARK: - 自定义构造函数
    
    /// 根据外部传递过来的参数自定义背景view
    /// - 参数frame: 表示背景view的frame
    /// - 参数parentVc: 表示父控制器
    init(frame: CGRect, parentVc: UIViewController) {
        
        // 将外部传递过来的参数保存到私有属性中
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PlayButtonView {
    
    // 统一设置UI界面
    fileprivate func setupUI() {
//        backgroundColor = .blue
        // 添加normalImageView
        addSubview(imageView)
        
        // 添加中间的播放按钮
        addSubview(playButton)
    }
    
    /// 调整子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playButton.center = imageView.center
    }
    
}


/// 监听按钮的点击
extension PlayButtonView {
    
    /// 点击中间的播放按钮，弹出控制器
    @objc fileprivate func playButtonClick() {
        
        
        // FIXME: - 得用代理通知MainViewController控制器push另一个控制器
        
        print("PlayButtonView---点击了tabBar中间的播放按钮")
    }
}
