//
//  RecommendHotWordGridView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// cell的可重用标识符
private let kCellIdentifier = "kCellIdentifier"

/// 分割线的宽度
private let kLineWidth: CGFloat = 0.7

class RecommendHotWordGridView: UIView {
    
    // MARK: - 模型属性
    
    /// 用于接收从控制器传递过来的模型数据
    var hotWordGridModelArray: [HotWordGridModel]? {
        
        didSet {
            // 刷新数据
            collectionView.reloadData()
        }
    }

    // MARK: - 私有属性
    fileprivate var hotWordGridViewHeight: CGFloat
    

    // MARK: - 懒加载属性
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth * 0.5, height: hotWordGridViewHeight * 0.5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.register(RecommendHotWordGridCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        
        return collectionView
    }()
    
    /// 水平分割线
    fileprivate lazy var horizontalLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return view
    }()
    
    
    /// 垂直分割线
    fileprivate lazy var verticalLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        return view
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
    
    
    /*
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
        ctx.setLineWidth(1)

        // 设置线条的颜色
        UIColor.lightGray.setStroke()

        // 将上下文中的内容显示到view控件上(即渲染到view的layer上，通常用stroke或者fill)
        ctx.strokePath()
    }
    */
}




// MARK: - 设置UI界面
extension RecommendHotWordGridView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加collectionView
        addSubview(collectionView)
        
        // 添加水平分割线
        collectionView.addSubview(horizontalLine)
        
        // 添加垂直分割线
        collectionView.addSubview(verticalLine)
    }
    
    
    // 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 布局水平分割线
        horizontalLine.snp.makeConstraints { (make) in
            make.width.equalTo(frame.size.width)
            make.height.equalTo(kLineWidth)
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        // 布局垂直分割线
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(kLineWidth)
            make.height.equalTo(frame.size.height)
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        }
    }
}



// MARK: - UICollectionViewDataSource
extension RecommendHotWordGridView: UICollectionViewDataSource {
    
    // 返回cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //
        guard let hotWordGridModelArray = hotWordGridModelArray else { return 0 }
        
        //
        let typeItem = hotWordGridModelArray[section]
        
        //
        guard let titleItem = typeItem.hotWordGridDataModelArray.first else { return 0 }
        
        //
        guard let count = titleItem.data?.count else { return 0 }
        
        return count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as! RecommendHotWordGridCell
        
        //
        guard let hotWordGridModelArray = hotWordGridModelArray else { return cell }
        
        //
        let typeItem = hotWordGridModelArray[indexPath.section]
        
        //
        guard let titleItem = typeItem.hotWordGridDataModelArray.first else { return cell }
        
        //
        let dataItem = titleItem.hotWordGridDataDataModelArray[indexPath.row]
        
        // 设置cell的数据
        cell.cellTitleLabel.text = dataItem.title
        cell.cellImageView.kf.setImage(with: URL(string: dataItem.imgUrl))
        
        return cell
    }
}