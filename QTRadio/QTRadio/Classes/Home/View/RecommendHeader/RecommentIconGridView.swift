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
    
    // MARK: - 模型属性
    
    /// 用于接收从控制器传递过来的模型数据
    var iconGridModelArray: [IconGridModel]? {
        
        didSet {
            // 监听iconGridModelArray数据的改变
            // 一旦有数据，就刷新表格
            collectionView.reloadData()
        }
    }
    
    

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
        collectionView.backgroundColor = .white
        
        
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
        
        // 再取出分组模型
        let typeItem = iconGridModelArray?[section]
        
        // 接着取出标题模型
        let titleItem = typeItem?.iconGridDataModelArray.first
        
        // 最后取出标题模型中存放数据的数组，其元素个数就是每一行cell的个数
        let count = titleItem?.data?.count
        
        return count ?? 10
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! RecommendIconGridViewCell
        
        // 先校验数组iconGridModelArray是否有值
        guard let iconGridModelArray = iconGridModelArray else { return cell }
        
        // 再取出分组模型
        let typeItem = iconGridModelArray[indexPath.section]
        
        // 接着取出标题模型
        guard let titleItem = typeItem.iconGridDataModelArray.first else { return cell }
        
        // 然后取出行模型
        let dataItem = titleItem.iconGridDataDataModelArray[indexPath.row]
        
        // 设置数据
        cell.cellTitleLabel.text = dataItem.title
//        cell.cellImageView.kf.setImage(with: URL(string: dataItem.imgUrl))
        cell.cellImageView.setImage(dataItem.imgUrl)
        
        return cell
    }
}
