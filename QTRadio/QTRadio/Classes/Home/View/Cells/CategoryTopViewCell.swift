//
//  CategoryTopViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import SnapKit

/// 间距
private let kMargin: CGFloat = 22

class CategoryTopViewCell: UICollectionViewCell {
    
    // MARK: - 私有属性
    fileprivate var cellWidth: CGFloat
    fileprivate var cellHeight: CGFloat
    
    // MARK: - 对外公开属性
    
    /// 是否隐藏图片
    var isImageViewHidden: Bool = false
    
    
    /// 是否隐藏分割线
    var isSeperateLineHidden: Bool = false
    
    
    /// 是否需要红色遮盖
    var isNeedRedCover: Bool = false
    
    
    /// 是否需要蓝色遮盖
    var isNeedBlueCover: Bool = false
    
    
    // MARK: - 控件属性
    
    /// 图片控件
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taxonomy_category_3617_54x54_")
        return imageView
    }()
    
    /// 标题
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "精品内容"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    /// 箭头
    fileprivate lazy var arrow: UIImageView = {
        
        let arrow = UIImageView()
        arrow.image = UIImage(named: "album_desc_more_6x10_")
        arrow.sizeToFit()
        return arrow
    }()
    
    /// 分割线
    fileprivate lazy var seperateLine: UIImageView = {
        
        let seperateLine = UIImageView()
        seperateLine.isHidden = false
        seperateLine.image = UIImage(named: "whiteLine_40x1_")
        return seperateLine
    }()
    
    
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.cellWidth = frame.size.width
        self.cellHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension CategoryTopViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加imageView
        if isImageViewHidden == false {
            addSubview(imageView)
        }
        
        // 添加titleLabel
        addSubview(titleLabel)
        
        // 添加箭头
        addSubview(arrow)
        
        // 添加分割线
        if isSeperateLineHidden == false {
            addSubview(seperateLine)
        }
    }
    
    /// 重新布局子控件
    override func layoutSubviews() {
        
        // 布局imageView
        if isImageViewHidden == false {
            imageView.snp.makeConstraints { (make) in
                make.width.equalTo(cellHeight * 0.5)
                make.height.equalTo(cellHeight * 0.5)
                make.left.equalTo(self).offset(kMargin)
                make.centerY.equalTo(self)
            }
        }
        
        // 布局titleLabel
        if isImageViewHidden == false {
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(imageView.snp.right).offset(kMargin)
                make.centerY.equalTo(self)
            }
        } else {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(kMargin)
                make.centerY.equalTo(self)
            })
        }
        
        // 布局箭头
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-kMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局分割线
        if isSeperateLineHidden == false {
            seperateLine.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(kMargin)
                make.bottom.equalTo(self)
                make.right.equalTo(self).offset(-kMargin)
                make.height.equalTo(0.5)
            }
        }
    }
}
