//
//  DailyViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 纯代码实现今日推荐页面tableView的cell，还有一些
// 很重要的细节没有实现

import UIKit

/// cell距离屏幕左右的间距
private let kMarigin: CGFloat = 10

/// headerBar的高度
private let kHeaderBarHeight: CGFloat = 44

/// toolBar的高度
private let kToolBarHeight: CGFloat = 44

class DailyViewCell: UITableViewCell {
    
    // MARK: - 私有属性
    
    /// 图片的size
    fileprivate var imageSize: CGSize = CGSize.zero
    
    /// headerBar
    fileprivate lazy var headerBar: HeaderBar = {
        
        let headerBar = HeaderBar()
        return headerBar
    }()
    
    fileprivate lazy var recomendTitle: UILabel = {
        
        let label = UILabel()
        label.text = "推荐收听"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    
    /// 分类标题
    fileprivate lazy var categoryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "分类:"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    /// 次播放控件
    fileprivate lazy var ciTitle: UILabel = {
        
        let label = UILabel()
        label.text = "次播放"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    
    /// 用于保存正文描述控件的高度
//    fileprivate var myTextLabelHeight: CGFloat = 0
    
    
    /// 底部工具条
    fileprivate lazy var toolBar: UIView = {
        
        let toolBar = ToolBar()
        return toolBar
    }()
    
    
    
    // MARK: 对外暴露的属性
    
    /// 顶部标题
    lazy var topTitle: UILabel = {
        
        let label = UILabel()
        label.text = "赵忠祥：春天来了，又到了动物交配的季节"
        label.textColor = UIColor(r: 190, g: 158, b: 105)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    /// 左上角的配图
    lazy var myImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_image_loading_default")
        imageSize = (imageView.image?.size)!
        return imageView
    }()
    
    /// 主标题
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "矮大紧指北"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    
    /// 分类名称
    lazy var categoryTitle: UILabel = {
        
        let label = UILabel()
        label.text = "脱口秀"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        sizeToFit()
        return label
    }()
    
    
    /// 播放次数
    lazy var playCountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "16.7万"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    /// 正文简介label
    lazy var myTextLabel: UILabel = {
        
        let label = UILabel()
        label.text = "矮大紧指北"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    
    // 重写frame，调整cell上下左右的间距
    override var frame: CGRect{
        
        didSet {
            var newFrame = frame
            newFrame.origin.x += kMarigin
            newFrame.size.width -= 2 * kMarigin
            newFrame.origin.y += kMarigin
            newFrame.size.height -= kMarigin
            super.frame = newFrame
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
extension DailyViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        
        // 先移除cell里面所有的子控件
        for subview in contentView.subviews {
            
            subview.removeFromSuperview()
        }
        
        // 设置cell的圆角
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // 添加HeaderBar标题控件
        contentView.addSubview(headerBar)
        
        // 添加推荐标题label
        headerBar.addSubview(recomendTitle)
        
        // 添加顶部标题
        headerBar.addSubview(topTitle)
        
        // 添加图片控件
        contentView.addSubview(myImageView)

        // 添加主标题
        contentView.addSubview(titleLabel)

        // 添加分类标题
        contentView.addSubview(categoryLabel)

        // 添加分类名称控件
        contentView.addSubview(categoryTitle)

        // 添加播放次数
        contentView.addSubview(playCountLabel)

        // 添加次播放Label
        contentView.addSubview(ciTitle)

        // 添加正文Label
        contentView.addSubview(myTextLabel)

        // 添加底部工具条
        contentView.addSubview(toolBar)
    }
    
    
    override func layoutSubviews() {
        
        
        // 布局headerBar的位置
        headerBar.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.height.equalTo(kHeaderBarHeight)
            make.right.equalTo(self)
        }
        
        // 布局推荐标题控件的位置
        recomendTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerBar)
            make.left.equalTo(headerBar).offset(kMarigin)
        }
        
        // 布局顶部标题的位置
        topTitle.snp.makeConstraints { (make) in
            make.top.equalTo(recomendTitle)
            make.left.equalTo(recomendTitle.snp.right).offset(kMarigin)
        }
        
        
        
        
        // 布局imageView控件
        myImageView.snp.makeConstraints { (make) in
            make.top.equalTo(headerBar.snp.bottom).offset(kMarigin)
            make.left.equalTo(self).offset(kMarigin)
            make.width.equalTo(imageSize.width)
            make.height.equalTo(imageSize.height)
        }
        
        // 布局主标题的位置
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(myImageView).offset(kMarigin)
            make.left.equalTo(myImageView.snp.right).offset(kMarigin)
        }
        
        // 布局分类标题
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kMarigin * 1.5)
            make.left.equalTo(myImageView.snp.right).offset(kMarigin)
        }
        
        // 布局分类名称控件的位置
        categoryTitle.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.top)
            make.left.equalTo(categoryLabel.snp.right)
        }
        
        // 布局播放次数控件的位置
        playCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(myImageView.snp.bottom)
            make.left.equalTo(myImageView.snp.right).offset(kMarigin)
        }
        
        // 布局次播放Label
        ciTitle.snp.makeConstraints { (make) in
            make.top.equalTo(playCountLabel)
            make.left.equalTo(playCountLabel.snp.right)
        }
        
        // 布局正文Label
        myTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(myImageView.snp.bottom).offset(kMarigin)
            make.left.equalTo(self).offset(kMarigin)
            make.right.equalTo(self).offset(-kMarigin)
            make.bottom.equalTo(toolBar.snp.top).offset(-kMarigin)
        }
        
        // 布局底部工具条的位置
        toolBar.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(kToolBarHeight)
            make.bottom.equalTo(self)
        }
    }
}
