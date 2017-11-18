//
//  DownloadView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/2.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 主要是用来管理下载模块中暂无下载内容这个view

import UIKit


class DownloadView: UIView {
    
    // MARK: - 懒加载属性
    
    fileprivate var height: CGFloat = 0
    
    /// 图片和标题容器
    fileprivate lazy var container: UIView = {
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        return container
    }()
    
    /// 图片控件
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nodownload_134x100_")
        imageView.sizeToFit()
        return imageView
    }()
    
    /// 主标题控件
    fileprivate lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "暂无下载内容"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        return titleLabel
    }()
    
    /// 副标题
    fileprivate lazy var subtitle: UILabel = {
        
        let subtitle = UILabel()
        subtitle.text = "要离线收听，不耗流量？快吧想听的\n内容下载下来吧"
        subtitle.textAlignment = .center
        subtitle.textColor = .lightGray
        subtitle.font = UIFont.systemFont(ofSize: 12)
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.numberOfLines = 0
        return subtitle
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - UI界面
extension DownloadView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置控制器view的背景颜色
        backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 添加所有的子控件
        addSubviews()
    }
    
    /// 添加所有的子控件
    private func addSubviews() {
        
        // 添加container
        addSubview(container)
        
        // 添加图片控件
        container.addSubview(imageView)
        
        // 添加主标题
        container.addSubview(titleLabel)
        
        // 添加副标题
        container.addSubview(subtitle)
    }
    
    
    /// 设置子控件的约束
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置container的位置
        container.center = center
        
        // 约束图片控件的位置
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(container).offset(50)
            make.centerX.equalTo(container)
        }
        
        // 约束主标题的位置
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }
        
        // 约束副标题的位置
        subtitle.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(container)
        }
    }
}
