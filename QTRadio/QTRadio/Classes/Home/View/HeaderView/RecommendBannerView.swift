//
//  RecommendBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/11.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 推荐界面的无线轮播器(或者说banner)

import UIKit


/// collectionViewCell标识符
private let kBannerCellIdentifier = "kBannerCellIdentifier"

class RecommendBannerView: UIView {

    // MARK: - 控件属性
    
    /// collectionView控件
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    /// pageControl控件
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    // MARK: - 自定义构造函数
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 统一设置UI界面
        setupUI()
    }
    
    
    /// 类方法，快速创建一个RecommendBannerView
    class func recommendBannerView() -> RecommendBannerView {
        
        return Bundle.main.loadNibNamed("RecommendBannerView", owner: nil, options: nil)?.first as! RecommendBannerView
    }
}





// MARK: - 设置UI界面
extension RecommendBannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置RecommendBannerView不跟随父控件一起
        // 伸缩。如果忘记设置这个，最后会导致我们的控件
        // 被缩小得看不见了
        autoresizingMask = []
        
        // 注册cell
        bannerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kBannerCellIdentifier)
        
        //
    }
    
    /// 重新布局子控件的frame
    override func layoutSubviews() {
        
        // 取出系统默认的layout，并将其转成流水布局
        let layout = bannerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = bannerCollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.showsHorizontalScrollIndicator = false
    }
}



// MARK: - UICollectionViewDataSource
extension RecommendBannerView: UICollectionViewDataSource {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}
