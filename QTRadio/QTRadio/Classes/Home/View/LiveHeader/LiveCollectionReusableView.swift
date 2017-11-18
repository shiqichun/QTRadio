//
//  LiveCollectionReusableView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 和屏幕左边的间距
private let kLeftMargin: CGFloat = 15

/// 通用间距
private let kMargin: CGFloat = 10




class LiveCollectionReusableView: UICollectionReusableView {
    
    // MARK: - 私有属性
    
    /// 热门按钮
    fileprivate var hotButton: UIButton?
    
    /// 新秀按钮
    fileprivate var newButton: UIButton?
    
    /// 记录热门按钮的选中状态
    fileprivate var isHotBtnSelected: Bool = true
    
    /// 记录新秀按钮的选中状态
    fileprivate var isNewBtnSelected: Bool = false
    
    
    
    
    // MARK: - 懒加载属性
    
    /// 热门按钮
    fileprivate lazy var hotBtn: UIButton = {
        
        hotButton = UIButton(type: .custom)
        hotButton!.setTitle("热门", for: .normal)
        hotButton!.setTitle("热门", for: .selected)
        hotButton!.setTitleColor(.lightGray, for: .normal)
        hotButton!.setTitleColor(.red, for: .selected)
        hotButton!.isSelected = isHotBtnSelected
        hotButton!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        hotButton!.addTarget(self, action: #selector(hotBtnClick(_:)), for: .touchUpInside)
        hotButton!.sizeToFit()
        return hotButton!
    }()
    
    /// 垂直分割线
    fileprivate lazy var verticalLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    /// 新秀按钮
    fileprivate lazy var newBtn: UIButton = {
        
        newButton = UIButton(type: .custom)
        newButton!.setTitle("新秀", for: .normal)
        newButton!.setTitle("新秀", for: .selected)
        newButton!.setTitleColor(.lightGray, for: .normal)
        newButton!.setTitleColor(.red, for: .selected)
        newButton!.isSelected = isNewBtnSelected
        newButton!.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        newButton!.addTarget(self, action: #selector(newBtnClick(_:)), for: .touchUpInside)
        newButton!.sizeToFit()
        return newButton!
    }()
    
    /// 我要开直播
    fileprivate lazy var toLiveBtn: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage.imageWithStretchalbe("icon_input_record_indicator_cancel"), for: .normal)
        btn.setTitle("我要开直播", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.lightGray, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        btn.addTarget(self, action: #selector(toLiveBtnClick(_:)), for: .touchUpInside)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.sizeToFit()
        return btn
    }()
    
    
    // MAKR: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MAKR: - 设置UI界面
extension LiveCollectionReusableView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加hotBtn
        addSubview(hotBtn)
        
        // 添加垂直分割线
        addSubview(verticalLine)
        
        // 添加newBtn按钮
        addSubview(newBtn)
        
        // 添加toLiveBtn
        addSubview(toLiveBtn)
    }
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局hotBtn的位置
        hotBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kLeftMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局verticalLine的位置
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.height.equalTo(frame.size.height - kLeftMargin - kMargin)
            make.left.equalTo(hotBtn.snp.right).offset(kMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局新秀按钮的位置
        newBtn.snp.makeConstraints { (make) in
            make.left.equalTo(verticalLine.snp.right).offset(kMargin)
            make.centerY.equalTo(self)
        }
        
        // 布局toLiveBtn的位置
        toLiveBtn.snp.makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(24)
            make.right.equalTo(self).offset(12)
            make.centerY.equalTo(self)
        }
    }
}




// MARK: - 监听按钮的点击
extension LiveCollectionReusableView {
    
    /// 监听热门按钮的点击
    @objc fileprivate func hotBtnClick(_ btn: UIButton) {
        
        hotButton!.isSelected = true
        isHotBtnSelected = hotButton!.isSelected
        
        newButton!.isSelected = false
        isNewBtnSelected = newButton!.isSelected
        
        // 切换到热门数据
        
    }
    
    /// 监听新秀按钮的点击
    @objc fileprivate func newBtnClick(_ btn: UIButton) {
        
        
        newButton!.isSelected = true  // 改变状态
        isNewBtnSelected = newButton!.isSelected  // 保存状态
        
        hotButton!.isSelected = false // 改变状态
        isHotBtnSelected = hotButton!.isSelected  // 保存状态
        
        // 切换到新秀数据
    }
    
    /// 监听我要直播按钮的点击
    @objc fileprivate func toLiveBtnClick(_ btn: UIButton) {
        
        //
        print("LiveCollectionReusableView---\(btn)")
    }
}

