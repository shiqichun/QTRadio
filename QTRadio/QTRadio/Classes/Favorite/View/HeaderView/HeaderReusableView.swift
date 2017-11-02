//
//  HeaderReusableView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/2.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit
import SnapKit


// 间距
private let kMargin: CGFloat = 15

class HeaderReusableView: UICollectionReusableView {
    
    
    // MARK: - 懒加载属性
    
    /// 左边的标题
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "推荐专辑"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    /// 右边的按钮
    fileprivate lazy var moreBtn: UIButton = {
        
        // 创建按钮
        let moreBtn = UIButton()
        moreBtn.setImage(UIImage(named: "moreBtnFree"), for: .normal)
        moreBtn.setTitle("更多推荐", for: .normal)
        moreBtn.sizeToFit()
        
        // 取出按钮中imageView和titleLabel的宽度
        let imageViewWidth = moreBtn.imageView!.bounds.size.width
        let titleLabelWidth = moreBtn.titleLabel!.bounds.size.width
        
        // 重新设置imageView和titleLabel的内边距
        moreBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageViewWidth, bottom: 0, right: imageViewWidth)
        moreBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageViewWidth + 10, bottom: 0, right: -titleLabelWidth)
        
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moreBtn.setTitleColor(UIColor.darkGray, for: .normal)
        moreBtn.addTarget(self, action: #selector(HeaderReusableView.moreBtnClick), for: .touchUpInside)
        
        return moreBtn
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



// MARK: - 设置UI界面
extension HeaderReusableView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加所有的子控件
        addSubviews()
        
        // 给headerView添加点击手势
        addTapGesture()
    }
    
    /// 设置所有的子控件
    private func addSubviews() {
        
        // 添加标题
        addSubview(titleLabel)
        
        // 添加按钮
        addSubview(moreBtn)
    }
    
    // 布局子控件的位置
    override func layoutSubviews() {
        
        // 布局titleLabel的位置
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin)
            make.centerY.equalTo(self)
        }
        
        
        // 布局moreBtn的位置
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-kMargin)
            make.centerY.equalTo(self)
        }
    }
    
    
    /// 给headerView添加点击手势
    private func addTapGesture() {
        
        // 创建点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerViewTapClick(_:)))
        addGestureRecognizer(tapGesture)
    }
}




// MARK: - 监听按钮的点击
extension HeaderReusableView {
    
    // FIXME: - 可以考虑将这两个方法合成一个
    
    // 更多按钮的点击
    @objc fileprivate func moreBtnClick() {
        
        // 点击这里需要push控制器
        print("moreBtnClick")
    }
    
    @objc fileprivate func headerViewTapClick(_ gesture: UIGestureRecognizer) {
        
        // 点击这里需要push控制器
        print(gesture)
    }
}
