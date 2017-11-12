//
//  RecommentIconGridView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// item之间的间距

/// item的宽度
private let kItemWidth: CGFloat = kScreenWidth / 5.0

/// collectionView的cell可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"



class RecommentIconGridView: UIView {

    // MARK: - 私有属性
    fileprivate var iconGridViewHeight: CGFloat
    
    // MARK: - 控件属性
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: iconGridViewHeight * 0.5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: iconGridViewHeight)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        
        
        collectionView.dataSource = self
        collectionView.register(RecommendIconGridViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        return collectionView
    }()
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.iconGridViewHeight = frame.size.height
        
        // 初始化父类的属性
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension RecommentIconGridView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        addSubview(collectionView)
    }
}




// MARK: - UICollectionViewDataSource
extension RecommentIconGridView: UICollectionViewDataSource {
    
    // 返回每一行cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! RecommendIconGridViewCell
        
        return cell
    }
}
