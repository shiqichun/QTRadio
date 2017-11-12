//
//  CategoryTopView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// cell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"

class CategoryTopView: UIView {
    
    // MARK: - 私有属性
    fileprivate var topViewHeight: CGFloat
    

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth * 0.5, height: topViewHeight / 4.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.register(CategoryTopViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        return collectionView
    }()
    
    
    /// 红色的背景
    fileprivate lazy var redBackView: UIView = {
        
        let redBackView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth * 0.5, height: topViewHeight / 4.0))
        let imageView = UIImageView(frame: redBackView.bounds)
        imageView.image = UIImage(named: "red_cover_188x56_")
        redBackView.addSubview(imageView)
        return redBackView
    }()
    
    
    /// 蓝色的背景
    fileprivate lazy var blueBackView: UIView = {
        
        let blueBackView = UIView(frame: CGRect(x: kScreenWidth * 0.5, y: 0, width: kScreenWidth * 0.5, height: topViewHeight / 4.0))
        let imageView = UIImageView(frame: blueBackView.bounds)
        imageView.image = UIImage(named: "blue_cover_188x56_")
        blueBackView.addSubview(imageView)
        return blueBackView
    }()
    
    
    /// 模型属性
    fileprivate lazy var topViewModelArr: [CategoryTopViewModel] = [CategoryTopViewModel]()
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.topViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




// MARK: - 设置UI界面
extension CategoryTopView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        addSubview(collectionView)
        
        // 加载plist中的文件
        loadData()
    }
    
    /// 加载plist文件中的数据，并且将其转为模型
    fileprivate func loadData() {
        
        // 获取plist文件的路径
        guard let filePath = Bundle.main.path(forResource: "CategoryTopViewCell.plist", ofType: nil) else { return }
        
        // 加载plist文件中的数据，然后将其存放到数组中
        let dictArr = NSArray(contentsOfFile: filePath) as! [[String: Any]]
        
        // 遍历数组中的字典
        for dict in dictArr {
            
            // 将字典转为模型
            let item = CategoryTopViewModel(dict: dict)
            
            // 将转换完成的模型存储在模型数组中
            topViewModelArr.append(item)
        }
    }
}




// MARK: - UICollectionViewDataSource
extension CategoryTopView: UICollectionViewDataSource {
    
    // 返回cell的行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topViewModelArr.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath) as! CategoryTopViewCell
        
        // 设置cell的背景颜色
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor(r: 252, g: 140, b: 144) : UIColor(r: 149, g: 196, b: 251)
        
        if indexPath.item == 0 {
            cell.backgroundView = redBackView
        }
        
        if indexPath.item == 1 {
            cell.backgroundView = blueBackView
        }
        
        // 取出模型
        let item = topViewModelArr[indexPath.row]
        
        if item.imageName != "" {
            cell.imageView.image = UIImage(named: item.imageName)
        }
        
        cell.titleLabel.text = item.title
        cell.isImageViewHidden = item.isImageViewHidden
        cell.isSeperateLineHidden = item.isSeperateLineHidden
        
        return cell
    }
}
