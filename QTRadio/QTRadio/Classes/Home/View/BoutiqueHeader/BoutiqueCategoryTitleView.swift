//
//  BoutiqueCategoryTitleView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// titleView的行数
private let kRows = 2

/// titleView的列数
private let kCols = 4

/// cell的可重用标识符
private let kCollectionViewCellidentifer = "kCollectionViewCellidentifer"


class BoutiqueCategoryTitleView: UIView {
    
    // MARK: - 私有属性
    
    /// categoryTitleView的宽度
    fileprivate var titleViewWidthd: CGFloat
    
    /// categoryTitleView的高度
    fileprivate var titleViewHeight: CGFloat

    
    // MARK: - 懒加载控件
    
    /// 用于展示标题控件的collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: titleViewWidthd / CGFloat(kCols), height: titleViewHeight / CGFloat(kRows))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.register(BoutiqueCategoryTitleCell.self, forCellWithReuseIdentifier: kCollectionViewCellidentifer)
        
        return collectionView
    }()
    
    
    /// 用户存储转换完成的模型数据
    fileprivate lazy var modelArray:[BoutiqueCategoryTitleModel] = [BoutiqueCategoryTitleModel]()
    
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.titleViewWidthd = frame.size.width
        self.titleViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension BoutiqueCategoryTitleView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置collectionView的背景颜色
        backgroundColor = .white
        
        // 添加collectionView
        addSubview(collectionView)
        
        // 从plist文件中加载数据
        loadPlistData()
    }
}



// MARK: - 加载plist文件中的数据
extension BoutiqueCategoryTitleView {
    
    /// 将plist文件中的字典数据转成模型
    fileprivate func loadPlistData() {
        
        // 获取plist文件的路径
        guard let path = Bundle.main.path(forResource: "BoutiqueCategoryTitleCell", ofType: "plist") else { return }
        
        // 从plist文件中读取数据，并且将其存放到数组中
        let dictArr = NSArray(contentsOfFile: path) as! [[String: Any]]
        
        // 遍历数组dictArr，取出里面的字典
        for dict in dictArr {
            
            // 将字典转为模型
            let item = BoutiqueCategoryTitleModel(dict: dict)
            
            // 将转换完成的模型数据存储起来
            modelArray.append(item)
        }
    }
}





// MARK: - UICollectionViewDataSource
extension BoutiqueCategoryTitleView: UICollectionViewDataSource {
    
    // 返回cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return modelArray.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellidentifer, for: indexPath) as! BoutiqueCategoryTitleCell
        
        // 取出模型
        let item = modelArray[indexPath.row]
        
        // 设置cell的标题
        cell.cellTitleLabel.text = item.title
        
        // 设置cell文字的颜色
        if item.isDarkGray {
            cell.cellTitleLabel.textColor = .darkGray
        } else {
            cell.cellTitleLabel.textColor = .black
        }
        
        // 设置cell的小箭头
        cell.cellArrow.isHidden = item.isHiddenArrow
        
        return cell
    }
}
