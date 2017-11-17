//
//  LiveBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/17.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// collectionViewCell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"

class LiveBannerView: UIView {
    
    // MARK: - 模型属性
    
    /// 用于接收从外部传递过来的bannerModel
    var bannerModelArray: [LiveBannerModel]? {
        
        didSet {
            
            // 监听bannerModelArray的变化，一旦发现控制器
            // 将模型数据传递过来，重新刷新表格
            bannerCollectionView.reloadData()
        }
    }
    
    // MARK: - 私有属性
    
    /// 保存bannerView的高度
    fileprivate var bannerViewHeight: CGFloat
    
    
    // MARK: - 懒加载属性
    
    /// collectionView
    lazy var bannerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: bannerViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.register(LiveBannerViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        return collectionView
    }()
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.bannerViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension LiveBannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        addSubview(bannerCollectionView)
    }
}





// MARK: -
extension LiveBannerView: UICollectionViewDataSource {
    
    // 返回cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 从bannerModelArray中取出items模型
        let bannerItem = bannerModelArray?.first
        
        // 取出items模型的个数
        let count = bannerItem?.bannerItemsModelArray.count
        
        return (count ?? 6) * 10000
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! LiveBannerViewCell

        // 校验Banner模型是否有值
        guard let bannerModelArray = bannerModelArray else { return cell }
        
        // 取出banner模型数据
        guard let bannerItem = bannerModelArray.first else { return cell }
        
        // 从banner模型中取出bannerItem模型
        let item = bannerItem.bannerItemsModelArray[indexPath.item % bannerItem.bannerItemsModelArray.count]
        
        // 设置cell的图片数据
        cell.cellImageView.kf.setImage(with: URL(string: item.cover))
        
        return cell
    }
}
