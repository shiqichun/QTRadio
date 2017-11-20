//
//  LiveCollectionViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// image的宽度和高度是4：3

import UIKit

/// 挂件的宽度
private let kPendantWidth: CGFloat = 45

/// 挂件的高度
private let kPendantHeight: CGFloat = 20



class LiveCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - 私有属性
    
    /// cell的看宽度
    fileprivate var cellWidth: CGFloat
    
    /// cell的高度
    fileprivate var cellHeight: CGFloat
    
    /// cell图片的宽度
    fileprivate var cellImageWidth: CGFloat = 0
    
    /// cell图片的高度
    fileprivate var cellImageHeight: CGFloat = 0
    
    /// nickLabel的宽度
    fileprivate var nickLabelWidth: CGFloat = 0
    
    /// nickLabel的高度
    fileprivate var nickLabelHeight: CGFloat = 0
    
    
    
    
    
    // MARK: - 懒加载属性
    
    /// 图片控件
    lazy var cellImageView: UIImageView = {
        
        // 计算配图的宽度和高度
        cellImageWidth = cellWidth
        cellImageHeight = cellHeight * 3.0 / 4.0  // 图片宽度的四分之三
        
        // 创建imageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "live_placeholder_95x95_")
        return imageView
    }()
    
    /// nick_name控件(配图下面第一行左边文字)
    lazy var nickLabel: UILabel = {
        
        // 计算nickLabel的宽度和高度
        nickLabelWidth = cellWidth * 0.6  // 图片宽度的5分之3
        nickLabelHeight = cellHeight / 8.0  // 配图底部的label只占到了高度的四分之一，并且它有两行，所以其高度为cell高度的八分之一
        
        let label = UILabel()
        label.text = "你我他音悦台"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    /// tag控件(配图下面第一行右边文字)
    lazy var tagLabel: UILabel = {
        
        let label = UILabel()
        label.text = "#心动女神"
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        return label
    }()
    
    /// title控件(配图下面第二行灰色文字)
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "听过最美一句情话"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    /// livingLabel
    lazy var livingLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor(r: 14, g: 168, b: 83)
        label.text = "直播中"
        label.isHidden = true
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        
        return label
    }()
    
    
    /// 在人数线挂件
    lazy var pendantView: UIView = {
        
        let view = UIView()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: kPendantWidth, height: kPendantHeight)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.isHidden = true
        
        return view
    }()
    
    /// 在线人数图标(蜻蜓的美工太牛逼，实在是找不到原始图标，就随便搞一个)
    lazy var onlineImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "slight_32x32_")
        
        return imageView
    }()
    
    /// 在线人数label
    lazy var onlineLabel: UILabel = {
        
        let label = UILabel()
        label.text = "444"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 9)
        label.sizeToFit()
        
        return label
    }()
    
    
    // 预约背景控件
    lazy var reservationView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: cellImageWidth * 0.6, height: kPendantHeight))
        
        // 设置reservationView为半透明，但是添加到它上面的子控件不受影响
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = kPendantHeight * 0.5
        view.layer.masksToBounds = true
        view.isHidden = true
        
        return view
    }()
    
    // 预约小黄点
    lazy var reservationDot: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: 3))
        view.backgroundColor = UIColor(r: 250, g: 162, b: 54)
        view.layer.cornerRadius = 1.5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    // 预约时间label
    lazy var reservationTimeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "明天20:58"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 9)
        
        label.sizeToFit()
        
        return label
    }()
    
    // 预约label
    var reservationLabel: UILabel = {
        
        let label = UILabel()
        label.text = "预约"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 9)
        label.backgroundColor = UIColor(r: 250, g: 162, b: 54)
        
        return label
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
extension LiveCollectionViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 先移除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加配图控件
        contentView.addSubview(cellImageView)
        
        // 添加nickLabel
        contentView.addSubview(nickLabel)
        
        // 添加tagLabel
        contentView.addSubview(tagLabel)
        
        // 添加titleLabel
        contentView.addSubview(titleLabel)
        
        
        
        
        // 添加直播中标签
        cellImageView.addSubview(livingLabel)
        
        
        
        
        // 添加右下侧的在线挂件
        cellImageView.addSubview(pendantView)
        
        // 添加在线人数图标
        pendantView.addSubview(onlineImageView)
        
        // 添加在线人数label
        pendantView.addSubview(onlineLabel)
        
        
        
        
        // 添加在线预约View
        cellImageView.addSubview(reservationView)
        
        // 添加预约小黄点
        reservationView.addSubview(reservationDot)
        
        // 添加预约时间label
        reservationView.addSubview(reservationTimeLabel)
        
        // 添加预约label
        reservationView.addSubview(reservationLabel)
    }
    
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局cellImageView的位置
        cellImageView.snp.makeConstraints { (make) in
            make.width.equalTo(cellImageWidth)
            make.height.equalTo(cellImageHeight)
            make.top.equalTo(self)
            make.left.equalTo(self)
        }
        
        // 布局nickLabel的位置
        nickLabel.snp.makeConstraints { (make) in
            make.width.equalTo(nickLabelWidth)
            make.height.equalTo(nickLabelHeight)
            make.top.equalTo(cellImageView.snp.bottom)
            make.left.equalTo(self)
        }
        
        // 布局tagLabel的位置
        tagLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cellWidth * 0.4)
            make.height.equalTo(nickLabel)
            make.top.equalTo(cellImageView.snp.bottom)
            make.left.equalTo(nickLabel.snp.right)
        }
        
        // 布局titleLabel的位置
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cellImageWidth)
            make.height.equalTo(nickLabel)
            make.top.equalTo(nickLabel.snp.bottom)
            make.left.equalTo(self)
        }
        
        // 布局直播中标签的位置
        livingLabel.snp.makeConstraints { (make) in
            make.width.equalTo(kPendantWidth)
            make.height.equalTo(kPendantHeight)
            make.top.equalTo(cellImageView)
            make.left.equalTo(cellImageView)
        }
        
        // 布局pendantView的位置
        pendantView.snp.makeConstraints { (make) in
            make.width.equalTo(kPendantWidth)
            make.height.equalTo(kPendantHeight)
            make.right.equalTo(cellImageView)
            make.bottom.equalTo(cellImageView)
        }
        
        // 布局onlineImageView
        onlineImageView.snp.makeConstraints { (make) in
            make.width.equalTo(10)
            make.height.equalTo(10)
            make.left.equalTo(pendantView.snp.left).offset(5)
            make.centerY.equalTo(pendantView)
        }
        
        // 布局onlineLabel
        onlineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(onlineImageView.snp.right).offset(3)
            make.centerY.equalTo(pendantView)
        }
        
        // 布局reservationView的位置
        reservationView.snp.makeConstraints { (make) in
            make.width.equalTo(cellImageWidth * 0.6)
            make.height.equalTo(kPendantHeight)
            make.top.equalTo(cellImageView).offset(5)
            make.left.equalTo(cellImageView).offset(5)
        }
        
        // 布局预约小黄点
        reservationDot.snp.makeConstraints { (make) in
            make.width.equalTo(3)
            make.height.equalTo(3)
            make.left.equalTo(5)
            make.centerY.equalTo(reservationView)
        }
        
        // 布局reservationTimeLabel
        reservationTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(reservationDot.snp.right).offset(5)
            make.centerY.equalTo(reservationView)
        }
        
        // 布局reservationLabel
        reservationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(reservationView)
            make.left.equalTo(reservationTimeLabel.snp.right).offset(5)
            make.bottom.equalTo(reservationView)
            make.right.equalTo(reservationView)
        }
    }
    
    
    /// 清空循环利用的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImageView.image = UIImage(named: "live_placeholder_95x95_")
        nickLabel.text = nil
        tagLabel.text = nil
        titleLabel.text = nil
    }
}
