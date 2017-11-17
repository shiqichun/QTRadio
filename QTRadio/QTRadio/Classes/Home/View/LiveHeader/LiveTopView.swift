//
//  LiveTopView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// 通用间距
private let kMargin: CGFloat = 5

/// Banner的高度
private let kBannerHeight: CGFloat = 145

/// Billboards的高度(中间50，距离上下各为5)
private let kBillboardsHeight: CGFloat = 70


class LiveTopView: UIView {

    // MARK: - 私有属性
    
    /// topView的总高度
    fileprivate var topViewHeight: CGFloat
    
    
    // MARK: - 懒加载属性
    
    /// bannerView
    lazy var bannerView: LiveBannerView = {
        
        let view = LiveBannerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBannerHeight))
        return view
    }()
    
    
    /// billboardsView
    lazy var billboardsView: LiveBillboardsView = {
        
        let view = LiveBillboardsView(frame: CGRect(x: 0, y: topViewHeight - kBillboardsHeight, width: kScreenWidth, height: kBillboardsHeight))
        return view
    }()
    
    /// dotsView
    lazy var dotsView: LiveDotsView = {
        
        let view = LiveDotsView(frame: CGRect(x: 0, y: kBannerHeight, width: kScreenWidth, height: topViewHeight - kBannerHeight - kBillboardsHeight))
        return view
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.topViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}





// MARK: - 设置UI界面
extension LiveTopView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加Banner
        addSubview(bannerView)
        
        // 添加Dots
        addSubview(billboardsView)
        
        // 添加BillBoardS
        addSubview(dotsView)
    }
    
    
    /// 重新布局子控件的位置
}
