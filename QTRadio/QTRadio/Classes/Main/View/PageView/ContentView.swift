//
//  ContentView.swift
//  PageView
//
//  Created by Enrica on 2018/1/4.
//  Copyright © 2018年 Enrica. All rights reserved.
//

import UIKit


/// collectionViewCell的可重用标识符
private let kCollectionViewCellIdentifier = "kCollectionViewCellIdentifier"


/// ContentView的代理协议
protocol ContentViewDelegate: class {
    
    /// 将当前子控制器的index传递出去，以便对TitleView中的titleLabel做出相应的调整
    func contentView(_ contentView: ContentView, selectedControllerIndex: Int)
}

class ContentView: UIView {
    
    // MARK: - 对外暴露的属性
    
    /// ContentView的代理属性，用于通知TitleView中的label作出相应的调整
    weak var delegate: ContentViewDelegate?

    // MARK: - 私有属性
    
    /// 保存从containerView中传递过来的子控制器初始化设置
    fileprivate var initializeSetting: InitializeSettings
    
    /// 保存从containerView中传递过来的
    fileprivate var childViewControllers: [UIViewController]
    
    /// 保存从containerView中传递过来的
    fileprivate var parentViewController: UIViewController
    
    /// 默认选中的子控制器的下标
    fileprivate var selectedControllerIndex: Int
    
    
    // MARK: - 懒加载属性
    
    /// 懒加载collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        // 设置collectionView的frame
        let collectionViewFrame = self.bounds
        
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        
        // 设置layout的属性
        layout.itemSize = self.bounds.size  // 设置itemSize的大小
        layout.minimumInteritemSpacing = 0  // 设置itemSize之间的最小间距
        layout.minimumLineSpacing = 0  // 设置每一行itemSize之间的最小间距
        layout.scrollDirection = .horizontal  // 设置itemSize沿水平方向滚动
        
        // 创建collectionView
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        
        // 设置collectionView的属性
        collectionView.bounces = false  // 关闭弹力效果
        collectionView.showsVerticalScrollIndicator = false  // 禁用垂直滚动指示器
        collectionView.showsHorizontalScrollIndicator = false  // 禁用水平滚动指示器
        collectionView.scrollsToTop = false  // 关闭触摸状态栏以后自动滚到顶部的功能
        collectionView.isPagingEnabled = true  // 开启分页效果
        
        // 设置UICollectionViewDataSource的代理
        collectionView.dataSource = self
        
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellIdentifier)
        
        // 让ContentView成为代理
        collectionView.delegate = self
        
        return collectionView
    }()

    
    // MARK: - 自定义构造函数
    
    /// 用于创建容纳所有子控制器的contentView
    /// - 参数frame：表示contentView的frame
    /// - 参数initializeSetting：表示外部传递过来的初始化设置
    /// - 参数childViewControllers：表示所有的子控制器
    /// - 参数parentViewController：：表示父控制器
    init(frame: CGRect, initializeSetting: InitializeSettings, childViewControllers: [UIViewController], parentViewController: UIViewController) {
        
        // 初始化私有属性
        self.initializeSetting = initializeSetting
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        self.selectedControllerIndex = initializeSetting.defaultIndex
        
        // 调用父类的构造函数
        super.init(frame: frame)
        
        // 设置UI界面(添加子控制器)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension ContentView {
    
    /// 设置UI界面
    fileprivate func setupUI() {
        
        /**
         *  首先，非常重要的一步，需要将传递过来的子控制器添加到父控制器上。如果忘记这一步，
         *  后面再想在子控制器中执行push或modal操作，就会出现意外；
         *  其次，子控制器是可以滚动的，所以我们应该将子控制器添加到UIScrollView或者其子控件
         *  UICollectionView上面。由于涉及到子控制器的循环利用问题，因此，我们在这里采用UICollectionView。
         */
        
        // 遍历存放子控制器的数组childViewControllers
        for childViewController in childViewControllers {
            
            // 将子控制器添加到父控制器中
            parentViewController.addChildViewController(childViewController)
        }
        
        // 将collectionView添加到当前控件contentView中
        addSubview(collectionView)
        
        // 让子控制器滚动到默认下标值的位置
        scrollController(toIndex: selectedControllerIndex)
    }
}



// MARK: - UICollectionViewDataSource
extension ContentView: UICollectionViewDataSource {
    
    // 返回子控制器的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    
    // 返回子控制器
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 根据可重用标识符取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifier, for: indexPath)
        
        
        /**
         *  这里需要特别说明一下，这个cell的contentView并不是我们创建的那个contentView。每个
         *  cell在创建出来以后，里面会自带一个contentView，不要和前面创建的contentView搞混了。
         */
        // 在将子控制器添加到cell的contentView里面之前，先将它里面所有的子控件都移除掉
        for subView in cell.contentView.subviews {
            
            subView.removeFromSuperview()
        }
        
        // 从存放子控制器的数组childViewControllers中取出子控制器
        let childViewController = childViewControllers[indexPath.item]
        
        // 设置子控制器的frame
        childViewController.view.frame = cell.contentView.bounds
        
        // 最后再将子控制器的View添加到cell的contentView中
        cell.contentView.addSubview(childViewController.view)
        
        return cell
    }
}



// MARK: - 对外暴露的方法
extension ContentView {
    
    /// 让子控制器滚动到正确的位置
    func scrollController(toIndex: Int) {
        
        // 计算偏移量
        let offsetX = CGFloat(toIndex) * collectionView.frame.width
        
        // 重新设置contentSize
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}



// MARK: - UICollectionViewDelegate
extension ContentView: UICollectionViewDelegate {
    
    /**
     * 当我们滑动子控制器时，希望达到的效果是：顶部titleView中的标题也跟着同步滚动，
     * 为此，需要遵守UICollectionView的代理，实现它里面的代理协议，然后再监听它的
     * 滚动。所以，我们需要监听停止拖拽、拖拽停止减速，以及正在拖拽这些动作
     */
    
    // scrollView停止减速时调用(只调用一次)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 调用childViewControllerDidEndScroll()，将当前子控制器的index传递给外界
        childViewControllerDidEndScroll()
    }
    
    
    // scrollView停止拖拽时调用(只调用一次)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // 有一种可能，就是直接一下子拖到底了，并没有减速的过程，
        // 为此，我们需要在拖拽停止的时候处理一些事情。
        if !decelerate {  // 如果没有减速
            
            // 调用childViewControllerDidEndScroll()，将当前子控制器的index传递给外界
            childViewControllerDidEndScroll()
        }
    }
    
    /// 子控制器停止滚动时执行的操作
    private func childViewControllerDidEndScroll() {
        
        // 获取当前子控制器所在的位置(当前子控制器的index = 当前子控制器的偏移量 / collectionView的宽度)
        let selectedControllerIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        // 使用通知，将这个selectedControllerIndex传递给外面的TitleView，让其调整label的位置
        delegate?.contentView(self, selectedControllerIndex: selectedControllerIndex)
    }
    
    /// scrollView只要是发生滚动就会调用(滚动过程中一直调用)
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        //
//    }
}
