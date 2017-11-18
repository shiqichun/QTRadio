//
//  BoutiqueBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/16.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// cell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"

/// pageControl的高度
private let kPageControlHeight: CGFloat = 25


class BoutiqueBannerView: UIView {
    
    
    // MARK: - 模型属性
    
    /// 用于接收从控制器传递过来的模型属性
    var bannerModelArray: [BoutiqueBannerModel]? {
        
        didSet {
            // 监听bannerModelArray的变化，一旦
            // 发现它里面有数据，就刷新collectionView
            // 从而获取数据
            collectionView.reloadData()
            
            // 校验数组bannerModelArray是否有值
            guard let bannerModelArray = bannerModelArray else { return }
            
            // 如果数组bannerModelArray有值，则取出行模型的个数
            for sectionItem in bannerModelArray {
                
                // 从行模型数组中取出它的个数，并将其保存起来
                itemCount = sectionItem.bannerRecommendsModelArray.count
            }
            
            // 利用行模型的个数搞一个比较大的indexPath
            let indexPath = IndexPath(row: itemCount * 100, section: 0)
            
            // 往前滚动到这个indexPath
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            
            // 添加定时器
            removeBannerTimer()
            addBannerTimer()
        }
    }
    
    

    // MARK: - 私有属性
    
    /// 定时器属性
    fileprivate var bannerTimer: Timer?
    
    /// banner的宽度
    fileprivate var bannerWidth: CGFloat
    
    /// banner的高度
    fileprivate var bannerHeight: CGFloat
    
    /// 行模型的个数
    fileprivate var itemCount: Int = 0
    
    
    
    
    // MARK: - 懒加载属性
    
    /// 用于显示Banner的collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: bannerWidth, height: bannerHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.register(BoutiqueBannerCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    
    /// pageControl
    lazy var pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = UIColor(r: 245, g: 244, b: 249)
        pageControl.numberOfPages = 6
        
        return pageControl
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.bannerWidth = frame.size.width
        self.bannerHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension BoutiqueBannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加Banner
        addSubview(collectionView)
        
        // 添加pageControl
        addSubview(pageControl)
    }
    
    /// 布局子控件的位置
    override func layoutSubviews() {
        
        // 布局pageControl的位置
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(kPageControlHeight)
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
        }
    }
}





// MARK: - UICollectionViewDataSource
extension BoutiqueBannerView: UICollectionViewDataSource {
    
    // 返回cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 在取出分组模型
        let sectionItem = bannerModelArray?[section]
        
        let count = sectionItem?.bannerRecommendsModelArray.count
        
        // 从分组模型中取出行模型的个数，直接返回
        return (count ?? 6) * 10000
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! BoutiqueBannerCell
        
        // 先校验数组bannerModelArray是否有值
        guard let bannerModelArray = bannerModelArray else { return cell }
        
        // 再取出分组模型
        let sectionItem = bannerModelArray[indexPath.section]
        
        // 接着取出行模型
        let item = sectionItem.bannerRecommendsModelArray[indexPath.row % itemCount]
        
        // 设置cell的数据
        cell.cellImageView.kf.setImage(with: URL(string: item.thumb))
        
        return cell
    }
}




// MARK: - UICollectionViewDelegate
extension BoutiqueBannerView: UICollectionViewDelegate {
    
    // 监听collectionView的滚动，修改pageControl的currentPage
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取当前滚动的偏移量(主要是x轴方向上的滚动)。如果希望实现banner滚动到一半，currentPage就
        // 显示为下一个，只需要在contentOffsetX的基础上再加上banner宽度的一半即可，用代码描述如下：
        // let currentOffsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        let currentOffsetX = scrollView.contentOffset.x
        
        // 计算pageControl的currentIndex
        pageControl.currentPage = Int(currentOffsetX / scrollView.bounds.width) % itemCount
    }
    
    // 监听用户拖动手势，一旦用户手动拖拽bannerView，要将定时器移除
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        // 移除定时器
        removeBannerTimer()
    }
    
    // 用户结束拖拽bannerView，再次添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // 添加定时器
        addBannerTimer()
    }
}




// MARK: - 定时器相关的函数
extension BoutiqueBannerView {
    
    /// 添加定时器
    fileprivate func addBannerTimer() {
        
        // 创建定时器
        bannerTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(BoutiqueBannerView.scrollToFuture), userInfo: nil, repeats: true)
        
        // 将定时器添加到运行循环
        RunLoop.main.add(bannerTimer!, forMode: .commonModes)
    }
    
    /// 移除定时器
    fileprivate func removeBannerTimer() {
        
        // 移除定时器
        bannerTimer?.invalidate()
        
        // 清空定时器
        bannerTimer = nil
    }
    
    
    /// 执行滚动
    @objc fileprivate func scrollToFuture() {
        
        // 获取当前的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        
        // 计算需要执行的偏移量(当前的偏移量 + Banner的宽度)
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 执行滚动(也就是重新设置contentOffset)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
