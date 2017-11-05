//
//  FavoriteViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 收藏模块主控制器

import UIKit
import Kingfisher


/// item之间的间距
private let kItemMargin: CGFloat = 15

/// item的列数
private let kItemCols: CGFloat = 3

/// item的宽度
private let kItemWidth: CGFloat = (kScreenWidth - (kItemCols + 1) * kItemMargin) / kItemCols

/// item的高度
private let kItemHeight: CGFloat = kItemWidth * 1.3

/// CollectionViewCell的可重用标识
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"



/// headerReference的高度
private let kHeaderReferenceHeight: CGFloat = 44

/// headerReference的可重用标识符
private let kHeaderReferenceIdentifier = "kHeaderReferenceIdentifier"


/// 登录view的高度
private let kLoginViewHeight: CGFloat = 200





class FavoriteViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    /// 修改导航栏中间的标题
    fileprivate lazy var label: UILabel = {
        
        let label = UILabel()
        label.text = "我的收藏"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    /// 官方应用可能用的是tableView，因为用collectionView6个cell是不能滚动的，而官方却可以滚动
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
        collectionView.backgroundColor = .white
        
        
        
        // 设置collectionView随着父控件的宽度和高度一起拉伸
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        collectionView.dataSource = self
        
        // 注册cell
        collectionView.register(AlbumViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        
        // 注册header
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier)
        
        
        return collectionView
    }()
    
    
    /// 添加loginView
    fileprivate lazy var loginView: LoginView = {
        
        let loginViewFrame = CGRect(x: 0, y: -kLoginViewHeight, width: kScreenWidth, height: kLoginViewHeight)
        
        let loginView = LoginView(frame: loginViewFrame, parentVc: self)
        
        
        return loginView
    }()
    
    
    /// 网络请求的ViewModel属性
    fileprivate lazy var favoriteViewModel: FavoriteViewModel = FavoriteViewModel()
    

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
        collectionView.contentInset = UIEdgeInsets(top: kLoginViewHeight, left: 0, bottom: 0, right: 0)
        
        
        // 将loginView添加到collectionView中
        collectionView.addSubview(loginView)

        
        // 发送网络请求
        loadData()
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 自定义导航栏左边的按钮
        let leftBtn = UIButton(image: "myMessage_30x30_", highlightedImage: "myMessagepress_30x30_")
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 修改导航栏中间的标题
        navigationItem.titleView = label
        
        // 自定义导航栏右边的按钮
        let rightBtn = UIButton(image: "searchInNavigation_30x30_", highlightedImage: "searchInNavigationpress_30x30_")
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
}



// MARK: - 发送网络请求
extension FavoriteViewController {
    
    /// 发送网络请求，获取收藏模块中推荐专辑的数据
    fileprivate func loadData() {
        
        // 通过ViewModel属性来发送网络请求
        favoriteViewModel.requestData(completionHandler: {
            
            // 重新调用数据源方法
            self.collectionView.reloadData()
        })
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
        return favoriteViewModel.albumArr.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! AlbumViewCell
        
        // 取出模型
        let album = favoriteViewModel.albumArr[indexPath.row]
        
        // 设置标题
        cell.titleLabel.text = album.rec_words
        
        // 获取图片URL地址的字符串
        let url = URL(string: album.rec_thumb)
        
        // 设置图片
        cell.imageView.kf.setImage(with: url)
        
        return cell
    }
    
    // 返回headerReference
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 根据可重用标识符取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier, for: indexPath) as! HeaderReusableView
        
        return headerView
    }
}
