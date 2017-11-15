//
//  LiveViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中直播子控制器
// 因为直播界面的数据被加密了，没办法做，
// 所以只能搞一个WKWebView糊弄一下。

// 直播的top数据，前三个依次为Banner、热门分类、大咖榜和贡献榜
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/template?partner=&ptnp=HTTP/1.1

// 房间数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=HTTP/1.1

// https://api.zhibo.qingting.fm/v2/recommends/sections/13/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=

// 倾向于用这一个
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=1&page_size=20&room_ids=&partner=&ptnp=HTTP/1.1

// 上拉刷新数据
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=2&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=3&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=4&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=5&page_size=20&room_ids=&partner=&ptnp=
// https://api.zhibo.qingting.fm/v2/recommends/sections/12/items?page_num=6&page_size=20&room_ids=&partner=&ptnp=


// 直播数据
// http://api.zhibo.qingting.fm/v2/recommends/sections/14/random_items?wt=json&v=6.0.4&deviceid=093e8b7e24c02246fe92373727e4a92c&phonetype=iOS&osv=11.1.1&device=iPhone&pkg=com.Qting.QTTour

import UIKit
import WebKit




// item之间的间距
//private let kItemMargin: CGFloat = 15

// item的列数
//private let kItemCols: CGFloat = 2

// item的宽度
//private let kItemWidth: CGFloat = (kScreenWidth - (kItemCols + 1) * kItemMargin) / kItemCols

// item的高度
//private let kItemHeight: CGFloat = kItemWidth

// CollectionViewCell的可重用标识
//private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"




// headerReference的高度
//private let kHeaderReferenceHeight: CGFloat = 44

// headerReference的可重用标识符
//private let kHeaderReferenceIdentifier = "kHeaderReferenceIdentifier"



class LiveViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    
    /// collectionView
//    fileprivate lazy var collectionView: UICollectionView = {
//
//        // 创建Layout
//        let layout = UICollectionViewFlowLayout()
//
//        // 设置layout的尺寸
//        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
//
//        // 设置item之间的间距和行间距
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//
//        // 调整item的内间距
//        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
//
//
//        // 设置layout的header
//        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderReferenceHeight)
//
//
//        // 创建collectionView
//        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//
//        // 设置collectionView的背景颜色
//        collectionView.backgroundColor = UIColor(r: 245, g: 244, b: 249)
//
//        // 设置collectionView随着父控件的宽度和高度一起拉伸
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        // 设置数据源代理
//        collectionView.dataSource = self
//
//        // 注册cell
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
//
//
//        // 注册header
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier)
//
//
//        return collectionView
//    }()
    
    
    /// 网页控件
    fileprivate lazy var webView: WKWebView = {
        
        let webView = WKWebView()
        guard let url = URL(string: "https://m.zhibo.qingting.fm") else { return webView }
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }()
    
    
    override func loadView() {
        view = webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }
}





// MARK: - 设置UI界面
extension LiveViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        //view.addSubview(collectionView)
        
        // 设置collectionView的内边距
        //collectionView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 5, right: 0)
        
        // 添加webView
        webView.frame = view.bounds
    }
}





// MARK: - UICollectionViewDataSource
//extension LiveViewController: UICollectionViewDataSource {
//
//    // 返回每一组cell的行数
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 55
//    }
//
//    // 返回cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        // 根据可重用标识符取出cell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath)
//
//        cell.backgroundColor = UIColor.randomColor()
//
//        return cell
//    }
//
//    // 返回headerReference
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        // 根据可重用标识符取出header
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier, for: indexPath)
//
//        headerView.backgroundColor = UIColor.randomColor()
//
//        return headerView
//    }
//}

