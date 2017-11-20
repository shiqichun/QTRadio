//
//  RecommendViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中推荐子控制器

import UIKit

/// 通用间距
private let kMargin: CGFloat = 5

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


/// containerHeight的高度
private let kContainerHeight: CGFloat = 395



class RecommendViewController: UIViewController {
    
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
        
        // 设置item的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        
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
        collectionView.register(RecommendViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        
        // 注册header
        collectionView.register(RecommendReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier)
        
        
        return collectionView
    }()
    
    /// 顶部的containerView
    fileprivate lazy var contaierView: RecommendContainerView = {
        
        let contaierView = RecommendContainerView(frame: CGRect(x: 0, y: -kContainerHeight, width: kScreenWidth, height: kContainerHeight))
        
        // 设置数据
        
        return contaierView
    }()
    
    
    /// 网络请求
    fileprivate lazy var recommendViewModel = RecommendViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
}


// MARK: - 设置UI界面
extension RecommendViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        view.addSubview(collectionView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kContainerHeight, left: 0, bottom: kItemMargin, right: 0)
        
        // 将contaierView添加到collectionView上面
        collectionView.addSubview(contaierView)
        
        // 请求网络数据
        loadData()
    }
}



// MARK: - 请求网络数据
extension RecommendViewController {
    
    /// 发送网络请求，获取收藏模块中推荐专辑的数据
    fileprivate func loadData() {
        
        // 通过ViewModel属性来发送网络请求
        recommendViewModel.requestData(completionHandler: {
            
            // 重新调用数据源方法
            self.collectionView.reloadData()
            
            // 将bannerView的模型数据传递过去
            self.contaierView.bannerView.bannerModelArray = self.recommendViewModel.bannerModelArray
            
            // 将IconGridView的数据传递过去
            self.contaierView.iconGridView.iconGridModelArray = self.recommendViewModel.iconGridModelArray
            
            // 将hotWordGridView的数据传递过去
            self.contaierView.hotWordGridView.hotWordGridModelArray = self.recommendViewModel.hotWordGridModelArray
        })
    }
}




// MARK: - UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    
    // 返回collectionView的分组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        // 分组模型的数量就是分组数
        return recommendViewModel.recommendModelArray.count
    }
    
    // 返回每一组cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 先取出分组模型
        let typeItem = recommendViewModel.recommendModelArray[section]
        
        // 在取出标题模型
        guard let titleItem = typeItem.recommendDataModelArray.first else { return 0 }
        
        // 取出标题模型中包含数据的数组的个数
        guard let count = titleItem.data?.count else { return 0 }
        
        return count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! RecommendViewCell

        // 先取出分组模型
        let typeItem = recommendViewModel.recommendModelArray[indexPath.section]
        
        // 接着取出标题模型
        guard let titleItem = typeItem.recommendDataModelArray.first else { return cell }
        
        // 再取出行模型
        let dataItem = titleItem.recommendDataDataModelArray[indexPath.row]
        
        // 最后设置cell的数据
        cell.cellTitleLabel.text = dataItem.recWords
        cell.cellImageView.kf.setImage(with: URL(string: dataItem.imgUrl))
        cell.playCountLabel.text = dataItem.playCnt
        
        return cell
    }
    
    // 返回headerReference
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 根据可重用标识符取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier, for: indexPath) as! RecommendReusableView
        
        // 先取出分组模型
        let typeItem = recommendViewModel.recommendModelArray[indexPath.section]
        
        // 再取出类型模型
        guard let titleItem = typeItem.recommendDataModelArray.first else { return headerView }
    
        // 最后取出标题模型，并且将标题赋值给headerView
        headerView.titleLabel.text = titleItem.title
        
        return headerView
    }
}
