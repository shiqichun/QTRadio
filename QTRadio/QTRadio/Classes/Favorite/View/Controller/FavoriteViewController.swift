//
//  FavoriteViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


// item之间的间距
private let kItemMargin: CGFloat = 15

// item的列数
private let kItemCols: CGFloat = 3

// item的宽度
private let kItemWidth: CGFloat = (kScreenWidth - (kItemCols + 1) * kItemMargin) / kItemCols

// item的高度
private let kItemHeight: CGFloat = kItemWidth * 1.3

// CollectionViewCell的可重用标识
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"



// headerReference的高度
private let kHeaderReferenceHeight: CGFloat = 44

// headerReference的可重用标识符
private let kHeaderReferenceIdentifier = "kHeaderReferenceIdentifier"





class FavoriteViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// 修改导航栏中间的标题
    fileprivate lazy var label: UILabel = {
        
        let label = UILabel()
        label.text = "我的收藏"
        return label
    }()
    
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        // 创建Layout
        let layout = UICollectionViewFlowLayout()
        
        // 设置layout的尺寸
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        
        // 设置item之间的间距和行间距
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        // 设置item的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 5, right: kItemMargin)
        
        
        // 设置layout的header
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderReferenceHeight)
        
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // 设置collectionView的背景颜色
        collectionView.backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 设置collectionView随着父控件的宽度和高度一起拉伸
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        collectionView.dataSource = self
        
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        
        // 注册header
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier)
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
}



// MARK: - 设置UI界面
extension FavoriteViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加collectionView
        view.addSubview(collectionView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: kItemMargin, right: 0)
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条左边的按钮
        setupLeftBarButtonItem()
        
        // 修改导航栏中间的标题
        navigationItem.titleView = label
        
        // 添加导航条右边的按钮
        setupRightBarButtonItems()
    }
    
    /// 添加导航条左边的按钮
    private func setupLeftBarButtonItem() {
        
        // 自定义左边的按钮
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "myMessage_30x30_"), for: .normal)
        leftBtn.setImage(UIImage(named: "myMessagepress_30x30_"), for: .highlighted)
        leftBtn.sizeToFit()
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    
    /// 添加导航条右边的按钮
    private func setupRightBarButtonItems() {
        
        // 自定义左边的按钮
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "searchInNavigation_30x30_"), for: .normal)
        rightBtn.setImage(UIImage(named: "searchInNavigationpress_30x30_"), for: .highlighted)
        rightBtn.sizeToFit()
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        // 调整导航栏左边按钮与屏幕的距离
        let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightItem.width = -5
        navigationItem.rightBarButtonItems = [rightItem,UIBarButtonItem(customView: rightBtn)]
    }
}





// MAR: - 监听导航栏上面按钮的点击
extension FavoriteViewController {
    
    /// 监听导航条leftBarButtonItem的点击
    @objc fileprivate func leftBarButtonItemClick() {
        
        print("FavoriteViewController---leftBarButtonItemClick")
    }
    
    /// 监听导航条试听历史按钮点击
    @objc fileprivate func rightBarButtonItemClick() {
        
        print("FavoriteViewController---rightBarButtonItemClick")
    }
}






// MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    
    // 返回每一组cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    // 返回headerReference
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 根据可重用标识符取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier, for: indexPath)
        
        headerView.backgroundColor = UIColor.randomColor()
        
        return headerView
    }
}
