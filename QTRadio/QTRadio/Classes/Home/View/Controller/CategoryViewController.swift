//
//  CategoryViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中分类子控制器

import UIKit


/// item的宽度
private let kItemWidth: CGFloat = kScreenWidth / 4

/// item的高度
private let kItemHeight: CGFloat = kItemWidth * 1.2

/// CollectionViewCell的可重用标识
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"

/// 分类头部控件的高度
private let kCategoryHeaderHeight: CGFloat = kScreenHeight * 0.3

/// 间距
private let kMargin: CGFloat = 5

class CategoryViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        // 创建Layout
        let layout = UICollectionViewFlowLayout()
        
        // 设置layout的尺寸
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        
        // 设置item之间的间距和行间距
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // 设置collectionView的背景颜色
        collectionView.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 设置collectionView随着父控件的宽度和高度一起拉伸
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        collectionView.dataSource = self

        // 注册cell
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        return collectionView
    }()
    
    
    /// 分类页面顶部控件
    fileprivate lazy var categoryHeaderView: CategoryHeaderView = {
        
        let categoryHeaderView = CategoryHeaderView(frame: CGRect(x: 0, y: -kCategoryHeaderHeight, width: kScreenWidth, height: kCategoryHeaderHeight - kMargin))
        return categoryHeaderView
    }()
    
    
    /// 模型数组，用于存储转换完成的模型
    fileprivate lazy var categoryModelArr: [CategoryCollectionModel] = [CategoryCollectionModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
}




// MARK: - 设置UI界面
extension CategoryViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        view.addSubview(collectionView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCategoryHeaderHeight, left: 0, bottom: 15, right: 0)
        
        // 添加顶部的headerView
        collectionView.addSubview(categoryHeaderView)
        
        // 将plist文件中的数据转换为模型数据
        setupCollectionViewCellData()
    }
    
    
    /// 将plist文件中的字典数据转换为模型数据
    private func setupCollectionViewCellData() {
        
        // 获取plist文件的路径
        guard let filePath = Bundle.main.path(forResource: "Category.plist", ofType: nil) else { return }
        
        // 加载plist文件中的字典数据，然后将其存放在一个数组中
        let dictArr = NSArray(contentsOfFile: filePath) as! [[String : Any]]
        
        // 遍历数组中的字典
        for dict in dictArr {
            
            // 将字典转为模型
            let item = CategoryCollectionModel(dict: dict)
            
            // 将转换完成的模型存储到数组中
            categoryModelArr.append(item)
        }
    }
}




// MARK: - UICollectionViewDataSource
extension CategoryViewController: UICollectionViewDataSource {
    
    // 返回cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModelArr.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! CategoryCollectionCell
        
        // 从存储模型的数组categoryModelArr中取出数据模型
        let item = categoryModelArr[indexPath.row]
        
        // 设置cell的图片
        cell.imageView.image = UIImage(named: item.imageName)
        
        // 设置cell的标题
        cell.titleLabel.text = item.title
        
        // 返回cell
        return cell
    }
}
