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


/// pageControl的高度
private let kPageControlHeight: CGFloat = 25



class LiveBannerView: UIView {
    
    // MARK: - 模型属性
    
    /// 用于接收从外部传递过来的bannerModel
    var bannerModelArray: [LiveBannerModel]? {
        
        didSet {
            
            // 监听bannerModelArray的变化，一旦发现控制器
            // 将模型数据传递过来，重新刷新表格
            bannerCollectionView.reloadData()
            
            // 校验bannerModelArray是否有数据
            guard let bannerModelArray = bannerModelArray else { return }
            
            // 取出Banner
            let bannerItem = bannerModelArray.first!
            
            // 再取出Item行模型的个数，并且将其保存起来
            itemCount = bannerItem.bannerItemsModelArray.count
            
            // 搞一个超大的indexPath
            let indexPath = IndexPath(item: itemCount * 100, section: 0)
            
            // 往左边滚动到这个超大的indexPath
            bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            
            // 搞一个定时器
            removeBannerTimer()
            addBannerTimer()
        }
    }
    
    // MARK: - 私有属性
    
    /// 保存bannerView的高度
    fileprivate var bannerViewHeight: CGFloat
    
    /// 保存定时器
    fileprivate var bannerTimer: Timer?
    
    /// 行模型的个数
    fileprivate var itemCount: Int = 0
    
    
    
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
        
        
        // 设置代理，监听用户拖拽
        collectionView.delegate = self
        
        return collectionView
    }()
    
    
    /// pageControl
    fileprivate lazy var pageControl: UIPageControl = {
        
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
        
        // 添加pageControl
        addSubview(pageControl)
    }
    
    
    /// 布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局pageControl的位置
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(kPageControlHeight)
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
        }
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
        let item = bannerItem.bannerItemsModelArray[indexPath.item % itemCount]
        
        // 设置cell的图片数据
//        cell.cellImageView.kf.setImage(with: URL(string: item.cover))
        cell.cellImageView.setImage(item.cover)
        
        return cell
    }
}





// MARK: - 监听用户的拖拽动作
extension LiveBannerView: UICollectionViewDelegate {
    
    // 监听collectionView的滚动，修改pageControl的currentPage
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取当前滚动的偏移量
        let currentOffsetX = scrollView.contentOffset.x
        
        // 计算pageControl的currentIndex
        pageControl.currentPage = Int(currentOffsetX / scrollView.bounds.width) % itemCount
    }
    
    // 即将拖拽时停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeBannerTimer()
    }
    
    // 拖拽结束之后添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addBannerTimer()
    }
}




// MARK: - 定时器相关的操作
extension LiveBannerView {
    
    /// 添加定时器
    fileprivate func addBannerTimer() {
        
        // 创建定时器并将其进行保存
        bannerTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollToFuture), userInfo: nil, repeats: true)
        
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
    
    
    /// 滚动到下一个位置
    @objc fileprivate func scrollToFuture() {
        
        // 获取当前的contentOffsetX
        let currentOffsetX = bannerCollectionView.contentOffset.x
        
        // 计算需要滚动的距离
        let offsetX = currentOffsetX + bannerCollectionView.bounds.width
        
        // 滚动到下一个位置
        bannerCollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
