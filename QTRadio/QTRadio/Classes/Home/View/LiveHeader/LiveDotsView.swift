//
//  LiveDotsView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// headerViewHeight
private let kHeaderViewHeight: CGFloat = 40

/// 图片的宽度
private let keImageWidth: CGFloat = 80

/// 图片高度
private let kImageHeight: CGFloat = 60

/// collectionViewCell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"



class LiveDotsView: UIView {
    
    // MARK: - 私有属性
    
    /// 保存dotsView的高度
    fileprivate var dotsViewHeight: CGFloat
    
    
    // MARK: - 懒加载属性
    
    /// headerView
    fileprivate lazy var headerView: UIView = {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kHeaderViewHeight))
        return headerView
    }()
    
    /// titleLabel
    fileprivate lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "热门分类"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    /// collectionView
    lazy var dotsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: keImageWidth, height: kImageHeight)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: kHeaderViewHeight, width: kScreenWidth, height: kImageHeight), collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        
        collectionView.dataSource = self
        collectionView.register(LiveDotsViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        return collectionView
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.dotsViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension LiveDotsView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = .white
        
        // 添加headerView
        addSubview(headerView)
        
        // 添加titleLabel
        headerView.addSubview(titleLabel)
        
        // 添加collectionView
        addSubview(dotsCollectionView)
    }
    
    /// 重新布局子控件的位置
    override func layoutSubviews() {
        
        // 重新布局titleLabel的位置
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(15)
            make.centerY.equalTo(headerView)
        }
    }
}





// MARK: - UICollectionViewDataSource
extension LiveDotsView: UICollectionViewDataSource {
    
    // 返回cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! LiveDotsViewCell
        
        
        return cell
    }
}
