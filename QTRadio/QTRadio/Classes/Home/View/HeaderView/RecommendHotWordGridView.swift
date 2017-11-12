//
//  RecommendHotWordGridView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class RecommendHotWordGridView: UIView {

    // MARK: - 私有属性
    fileprivate var hotWordGridViewHeight: CGFloat

    // MARK: - 懒加载属性
    
    /// topLeftView  default_user_avatar_68x68_
    fileprivate lazy var topLeftView: RecommendHotWordGridItem = {
        
        let topLeft = RecommendHotWordGridItem(frame: CGRect(x: 0, y: 0, width: kScreenWidth * 0.5, height: hotWordGridViewHeight * 0.5), imageName: "hotWordIcon_placeholder_22x22_", title: "高晓松")
        return topLeft
    }()
    
    
    /// topRightView
    fileprivate lazy var topRightView: RecommendHotWordGridItem = {
        
        let topRight = RecommendHotWordGridItem(frame: CGRect(x: kScreenWidth * 0.5, y: 0, width: kScreenWidth * 0.5, height: hotWordGridViewHeight * 0.5), imageName: "hotWordIcon_placeholder_22x22_", title: "高晓松")
        return topRight
    }()
    
    
    /// bottomLeftView
    fileprivate lazy var bottomLeftView: RecommendHotWordGridItem = {
        
        let bottomLeft = RecommendHotWordGridItem(frame: CGRect(x: 0, y: hotWordGridViewHeight * 0.5, width: kScreenWidth * 0.5, height: hotWordGridViewHeight * 0.5), imageName: "hotWordIcon_placeholder_22x22_", title: "高晓松")
        return bottomLeft
    }()
    
    
    /// bottomRightView
    fileprivate lazy var bottomRightView: RecommendHotWordGridItem = {
        
        let bottomRight = RecommendHotWordGridItem(frame: CGRect(x: kScreenWidth * 0.5, y: hotWordGridViewHeight * 0.5, width: kScreenWidth * 0.5, height: hotWordGridViewHeight * 0.5), imageName: "hotWordIcon_placeholder_22x22_", title: "高晓松")
        return bottomRight
    }()
    
    

    // MARK: - 构造函数
    override init(frame: CGRect) {

        // 初始化私有属性
        self.hotWordGridViewHeight = frame.size.height

        // 初始化父类的属性
        super.init(frame: frame)

        // 统一设置UI界面
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 绘制分割线
    override func draw(_ rect: CGRect) {
        
        // 获取图形上下文
        guard let ctx: CGContext = UIGraphicsGetCurrentContext() else { return }
        
        // 创建路径对象
        let path: UIBezierPath = UIBezierPath()
        
        // 创建第一根线
        path.move(to: CGPoint(x: frame.width * 0.5, y: 0))  // 设置路径的起点
        path.addLine(to: CGPoint(x: frame.width * 0.5, y: frame.height))  // 设置路径的终点
        
        // 添加第二根线
        path.move(to: CGPoint(x: 0, y: frame.height * 0.5))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height * 0.5))
        
        // 将绘制的内容添加到上下文中
        ctx.addPath(path.cgPath)
        
        // 设置线宽
        ctx.setLineWidth(0.3)
        
        // 设置线条的颜色
        UIColor.lightGray.setStroke()
        
        // 将上下文中的内容显示到view控件上(即渲染到view的layer上，通常用stroke或者fill)
        ctx.strokePath()
    }
}




// MARK: - 设置UI界面
extension RecommendHotWordGridView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加topLeftView
        addSubview(topLeftView)
        
        // 添加topRightView
        addSubview(topRightView)
        
        // 添加bottomLeftView
        addSubview(bottomLeftView)
        
        // 添加bottomRightView
        addSubview(bottomRightView)
    }
}

