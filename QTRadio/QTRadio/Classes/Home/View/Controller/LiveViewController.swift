//
//  LiveViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 用来管理首页模块中直播子控制器



import UIKit




// item之间的间距
private let kItemMargin: CGFloat = 15

// item的列数
private let kItemCols: CGFloat = 2

// item的宽度
private let kItemWidth: CGFloat = (kScreenWidth - (kItemCols + 1) * kItemMargin) / kItemCols

// item的高度
private let kItemHeight: CGFloat = kItemWidth

// CollectionViewCell的可重用标识
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"




// headerReference的高度
private let kHeaderReferenceHeight: CGFloat = 44

// headerReference的可重用标识符
private let kHeaderReferenceIdentifier = "kHeaderReferenceIdentifier"



/// 顶部Banner、dots、biliboards的总高度
private let kTopViewHeight: CGFloat = 325



class LiveViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {

        // 创建Layout
        let layout = UICollectionViewFlowLayout()

        // 设置layout的尺寸
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)

        // 设置item之间的间距和行间距
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = kItemMargin

        // 调整item的内间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)


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
        collectionView.register(LiveCollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)


        // 注册header
        collectionView.register(LiveCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier)


        return collectionView
    }()
    
    
    /// 顶部Banner、Dots和BillBoards的总高度
    fileprivate lazy var liveTopView: LiveTopView = {
        
        let view = LiveTopView(frame: CGRect(x: 0, y: -kTopViewHeight, width: kScreenWidth, height: kTopViewHeight))
        return view
    }()
    
    
    
    /// viewModel属性
    fileprivate lazy var liveViewModel: LiveViewModel = LiveViewModel()
    
    
   
    

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
        view.addSubview(collectionView)
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kTopViewHeight, left: 0, bottom: 5, right: 0)
        
        // 添加liveTopView
        collectionView.addSubview(liveTopView)
        
        // 请求网络数据
        loadData()
    }
}




// MARK: - 请求网路数据
extension LiveViewController {
    
    /// 请求网络数据
    fileprivate func loadData() {
        
        // 通过viewModle发送网络请求
        liveViewModel.requestData {
            
            self.collectionView.reloadData()
            
            // 将Banner的模型数据传递过去
            self.liveTopView.bannerView.bannerModelArray = self.liveViewModel.bannerModelArray
            
            // 将Dots的模型数据传递过去
            self.liveTopView.dotsView.dotsModelArray = self.liveViewModel.dotsModelArray
            
            // 将Billboards的模型数据传递过去
            self.liveTopView.billboardsView.billboardsModelArray = self.liveViewModel.billboardsModelArray
        }
    }
}





// MARK: - UICollectionViewDataSource
extension LiveViewController: UICollectionViewDataSource {

    // 返回每一组cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return liveViewModel.hotModelArray.count
    }

    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! LiveCollectionViewCell

        // 取出模型
        let hotItem = liveViewModel.hotModelArray[indexPath.row]
        
        // 设置cell的图片
        cell.cellImageView.kf.setImage(with: URL(string: hotItem.cover))
        
        
        
        
        /// hotItem.room_status ==  0 表示休息
        /// hotItem.room_status ==  1 表示预约
        /// hotItem.room_status ==  2 表示直播
        
        
        // 如果是在休息(也就是currentModelArray和forecastModelArray里面都没有值)
        if hotItem.currentModelArray.count == 0 && hotItem.forecastModelArray.count == 0 {
            
            // 表示正在休息
            
            // 显示正在预约的透明控件
            cell.reservationView.isHidden = false
            
            // 更改小黄点为小红点
            cell.reservationDot.backgroundColor = .red
            
            // 更改预约时间label的文字为正在休息
            cell.reservationTimeLabel.text = "正在休息"
            
            // 隐藏预约label
            cell.reservationTitleLabel.isHidden = true
        }
        
        
        // 如果是正在直播(也就是currentModelArray里面有值，而forecastModelArray里面没有值)
        if hotItem.currentModelArray.count != 0 && hotItem.forecastModelArray.count == 0 {
            
            // 表示正在直播
            
            // 隐藏预约直播的透明控件
            cell.reservationView.isHidden = true
            
            // 显示正在直播label
            cell.livingLabel.isHidden = false
            
            // 现在在线人数背景控件
            cell.onlineView.isHidden = false
            
            // 设置在线人数
            cell.onlineLabel.text =  "\(hotItem.online_user)"
            
            
            
            // 从hotItem中取出currentItem
            for currentItem in hotItem.currentModelArray {
                
                // 设置cell的图片(因为hotItem.cover有时没有值，为了安全起见，设置两次)
                cell.cellImageView.kf.setImage(with: URL(string: currentItem.cover))
                
                
                // 设置cell的title
                cell.titleLabel.text = currentItem.title
            }
        }
        
        // 如果是预约直播(也就是currentModelArray里面没有值，而forecastModelArray里面有值)
        if hotItem.currentModelArray.count == 0 && hotItem.forecastModelArray.count != 0 {
            
            // 说明是预约直播
            
            
            // 隐藏正在直播控件
            cell.livingLabel.isHidden = true
            
            // 隐藏在线收听人数控件
            cell.onlineView.isHidden = true
            
            // 显示预约透明控件
            cell.reservationView.isHidden = false
            
            // 修改小红点为小黄点
            cell.reservationDot.backgroundColor = UIColor(r: 250, g: 162, b: 54)
            
            // 修改预约时间
            for forecastItem in hotItem.forecastModelArray {
                
                cell.reservationTimeLabel.text = NSDate.dealWith(timeString: forecastItem.scheduled_at)
                
                // 设置cell的图片
                cell.cellImageView.kf.setImage(with: URL(string: forecastItem.cover))
                
                // 设置cell的title
                cell.titleLabel.text = forecastItem.title
            }
        }
        
        
        
        
        
        
        
        // 设置用户昵称
        cell.nickLabel.text = hotItem.nick_name
        
        // 设置标签
        cell.tagLabel.text = "#" + hotItem.tag
        

        return cell
    }

    // 返回headerReference
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        // 根据可重用标识符取出header
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderReferenceIdentifier, for: indexPath) as! LiveCollectionReusableView

        

        return headerView
    }
}

