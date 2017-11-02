//
//  TitleView.swift
//  ContainerView
//
//  Created by Enrica on 2017/8/30.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

// MARK: - 代理协议

/// TitleView的代理协议
protocol TitleViewDelegate: class {
    
    /// 通过代理方法，将当前被点击titleLabel的下标值传递出去
    func titleView(_ titleView: TitleView, selectedTitleLabelIndex titleIndex: Int)
}



// MARK: - 重要的属性和方法

class TitleView: UIView {
    
    // MARK: - 对外暴露的属性
    
    // 代理属性
    weak var delegate: TitleViewDelegate?
    

    // MARK: - 私有属性
    
    // 保存从containerView中传递过来的标题titles
    fileprivate var titles: [String]
    
    // 保存从containerView中传递过来的标题样式titleStyle
    fileprivate var titleStyle: TitleStyle
    
    /// 保存titleLabel，以方便后面给它设置frame
    fileprivate lazy var titleLabels = [UILabel]()
    
    /// 保存当前被选中titleLabel的下标值
    fileprivate var selectedTitleLabelIndex: Int = 0
    
    
    // MARK: - 懒加载属性
    
    
    /// 懒加载titleScrollView
    fileprivate lazy var titleScrollView: UIScrollView = {
        
        // 创建titleScrollView
        let titleScrollView = UIScrollView()
        
        // 设置titleScrollView的frame
        titleScrollView.frame = self.bounds
        
        // 设置titleScrollView的背景颜色
        titleScrollView.backgroundColor = self.titleStyle.titleBackgroundColor
        
        
        // 适配iPhone X
        if #available(iOS 11.0, *) {
            
            // 消除底部指示器被遮挡的情况
            titleScrollView.contentInsetAdjustmentBehavior = .never
        }

        
        // 设置titleScrollView的相关属性
        titleScrollView.showsVerticalScrollIndicator = false  // 禁用垂直滚动条
        titleScrollView.showsHorizontalScrollIndicator = false  // 禁用水平滚动条
        titleScrollView.scrollsToTop = false  // 禁用触摸状态栏自动回到顶部的功能
        titleScrollView.bounces = false  // 禁用弹力效果
        
        
        return titleScrollView
    }()
    
    
    /// 懒加载TitleView底部的分割线
    fileprivate lazy var dividingLine: UIView = {
        
        // 创建分割线
        let dividingLine = UIView()
        
        // 设置分割线的frame
        dividingLine.frame = CGRect(x: 0, y: self.bounds.height - self.titleStyle.dividingLineHeight, width: self.bounds.width, height: self.titleStyle.dividingLineHeight)
        
        // 设置dividingLine的背景颜色
        dividingLine.backgroundColor = self.titleStyle.dividingLineBackgroundColor
        
        return dividingLine
    }()
    
    
    /// 懒加载指示器scrollSlice
    fileprivate lazy var scrollSlide: UIView = {
        
        // 创建指示器
        let scrollSlide = UIView()
        
        // 设置指示器的背景颜色
        scrollSlide.backgroundColor = self.titleStyle.scrollSlideBackgroundColor
        
        return scrollSlide
    }()
    
    
    /// 懒加载标题上面的遮盖coverView
    fileprivate lazy var coverView: UIView = {
        
        // 创建遮盖
        let coverView = UIView()
        
        // 设置遮盖的背景颜色
        coverView.backgroundColor = self.titleStyle.coverViewBackgroundColor
        
        // 设置遮盖的透明度
        coverView.alpha = self.titleStyle.coverViewAlpha
        
        return coverView
    }()
    
    
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String], titleStyle: TitleStyle) {
        
        // 初始化私有属性
        self.titles = titles
        self.titleStyle = titleStyle
        
        // 调用父类的构造函数
        super.init(frame: frame)
        
        // 设置UI界面(添加标题titleLabel、遮盖coverView和指示器scrollSlide)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}




/**
 *  下面的代码主要是负责TitleView的UI界面
 */
// MARK: - 设置UI界面
extension TitleView {
    
    /// 设置UI界面
    fileprivate func setupUI() {
        
        /**
         *  因为titleView上面的标题有时候是可以滚动的，所以，我们不能直接将其添加到titleView上面，
         *  而是应该先再titleView上面添加一个titleScrollView， 然后再将titleLabel添加到titleScrollView
         *  上面。并且，因为可以滚动和不可以滚动的titleLabel，它们的frame是不一样的，因此创建titleLabel
         *  和设置titleLabel的frame的代码应该分开写。
         */
        
        
        // 添加titleScrollView
        addSubview(titleScrollView)
        
        // 创建titleLabel
        setupTitleLabels()
        
        // 设置titleLabel的frame
        setupTitleLabelFrame()
        
        // 创建titleView和contentView的分割线
        setupDividingLine()
        
        // 添加指示器scrollSlide
        if titleStyle.isShowScrollSlide {
            
            // 如果需要显示指示器
            setupScrollSlide()
        }
        
        // 添加遮盖
        if titleStyle.isShowCoverView {
            
            // 如果需要显示coverView
            setupCoverView()
        }
        
    }
    
    /// 创建titleLabel
    private func setupTitleLabels() {
        
        // 遍历标题数组titles，取出标题文本和与之对应的下标值
        for (titleIndex, titleString) in titles.enumerated() {
            
            // 创建titleLabel
            let titleLabel = UILabel()
            
            // 设置titleLabel的背景颜色
            titleLabel.backgroundColor = titleStyle.titleBackgroundColor  
            
            // 将标题文本设置到titleLabel上面去
            titleLabel.text = titleString
            
            // 设置标题文本居中显示
            titleLabel.textAlignment = .center
            
            // 设置标题字体大小
            titleLabel.font = titleStyle.titleFont
            
            // 给标题控件titleLabel绑定tag
            titleLabel.tag = titleIndex
            
            // 设置标题文本的颜色
            titleLabel.textColor = titleIndex == 0 ? titleStyle.selectedTextColor : titleStyle.normalTextColor
            
            // 将titleLabel添加到titleScrollView上面
            titleScrollView.addSubview(titleLabel)
            
            // 将标题titleLabel存放在数组中
            titleLabels.append(titleLabel)
            
            
            
            /***** 给titleLabel添加点击手势 *****/
            
            
            // UILabel默认是不能交互的，必须先开启用户交互
            titleLabel.isUserInteractionEnabled = true
            
            // 创建点击手势
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TitleView.titleLabelClick(_:)))
            
            // 将点击手势添加到titleLabel上面
            titleLabel.addGestureRecognizer(tapGesture)
        }
    }
    
    /// 设置titleLabel的frame
    private func setupTitleLabelFrame() {
        
        // titleLabel的y值
        let titleLabelY: CGFloat = 0
        
        // titleLabel的高度
        let titleLabelHeight = titleStyle.titleViewHeight
        
        // titleLabel的x值
        var titleLabelX: CGFloat = 0
        
        // titleLabel的宽度
        var titleLabelWidth: CGFloat = 0
        
        // titleLabel的个数
        let titleCount: Int = titleLabels.count
        
        // 先从数组titleLabels中取出titleLabel及其下标
        for (titleIndex, titleLabel) in titleLabels.enumerated() {
            
            // 再来判断标题是否可以滚动
            if titleStyle.isScrollEnable {
                
                // 如果标题是可以滚动的
                
                /**
                 *  如果标题是可以滚动的，那么titleLabel的宽度计算起来就要稍微麻烦一点：
                 *      1、首先，我们需要人为确定titleLabel之间的间距；
                 *      2、其次，需要根据titleLabel上面文字的多少盒大小来计算相应的宽度。
                 */
                titleLabelWidth = (titleLabel.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: titleStyle.titleFont], context: nil).width
                
                
                
                /**
                 *  计算titleLabel的x值时，也需要分情况考虑：
                 *      1、首先，第一个titleLabel，也就是下标值为0的titleLabel，它举例最左边的间距最好是半个titleMargin；
                 *      2、其次，当前titleLabel的x值应该是与上一个titleLabel最大的x值相关的。
                 */
                if titleIndex == 0 {
                    
                    // 下标为0的titleLabel距离最左边屏幕的间距应该为半个titleMargin
                    titleLabelX = titleStyle.titleMargin * 0.5
                } else {
                    
                    // 先取出上一个titleLabel(titleIndex - 1就是上一个titleLabel的下标值)
                    let previousTitleLabel = titleLabels[titleIndex - 1]  // 这里不会发生数组越界，因为我们已经派出了titleIndex为0的情况
                    
                    // 再来计算当前titleLabel的x值(titleLabel的x值 = 上一个titleLabel最大的x值 + titleLabel之间的间距)
                    titleLabelX = previousTitleLabel.frame.maxX + titleStyle.titleMargin
                }
                
                
                
            } else {
                
                // 如果标题是不可以滚动的
                titleLabelWidth = bounds.width / CGFloat(titleCount)  // titleLabel的宽度 = 屏幕总宽度 / 标题个数
                titleLabelX = titleLabelWidth * CGFloat(titleIndex)  // titleLabel的x坐标 = titleLabel的宽度 * 与之对应的下标值
            }
            
            // 有了titleLabel的x和y坐标，以及宽度和高度，就可以设置它的frame了
            titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelWidth, height: titleLabelHeight)
        }
        
        // 设置titleScrollView的contentSize
        if titleStyle.isScrollEnable {
            
            // 如果标题可以滚动，必须设置titleScrollView的contentSize才有效(contentSize = 最后一个标题最大的x值 + titleLabel之间间距的一半)
            titleScrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + titleStyle.titleMargin * 0.5, height: 0)
        }
    }
    
    /// 创建titleView和contentView的分割线
    private func setupDividingLine() {
        
        // 将分割线添加到titleView上面
        addSubview(dividingLine)
    }
    
    /// 添加指示器scrollSlide
    private func setupScrollSlide() {
        
        // 将指示器添加到titleScrollView上面
        titleScrollView.addSubview(scrollSlide)
        
        // 设置scrollSlide的frame为第0个titleLabel的frame
        scrollSlide.frame = titleLabels.first!.frame
        
        // 取出标题数组中的第0个标题
        let titleText = titles.first!
        
        // 计算第0个标题的宽度
        let textWidht = (titleText as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: titleStyle.titleFont], context: nil).width
        
        // 修改scrollSlide的宽度为第0个标题文本的宽度
        scrollSlide.frame.size.width = textWidht
        
        // 修改scrollSlide中心点的x为第0个titleLabels中心点的x
        scrollSlide.center.x = titleLabels.first!.center.x
        
        // 修改scrollSlide的高度
        scrollSlide.frame.size.height = titleStyle.scrollSlideHeight
        
        // 修改scrollSlide的y坐标(scrollSlide的y坐标 = TitleView的高度 - scrollSlide自身的高度)
        scrollSlide.frame.origin.y = bounds.height - titleStyle.scrollSlideHeight
    }
    
    /// 添加遮盖
    private func setupCoverView() {
        
        // 因为coverView要跟着一起滚动，所以需要将其添加到titleScrollView上面
        titleScrollView.insertSubview(coverView, at: 0)
        /**
         *  这个遮盖不能直接添加到titleScrollView上面，否则，它会遮住titleLabel，
         *  这样一来，你就无法点击被它遮住的titleLabel了。正确的做法是，将coverView
         *  插入到titleLabel的下面，这样既有遮盖的效果，又不会妨碍titleLabel的点击。
         */
        
        // 从存放titleLabel的数组中取出第0个titleLabel
        let firstLabel = titleLabels[0]
        
        // 设置coverView的宽度
        var coverViewWidth = firstLabel.frame.width
        
        // 设置coverView的高度
        let coverViewHeight = titleStyle.coverViewHeight
        
        // 设置coverView的x坐标
        var coverViewX = firstLabel.frame.origin.x
        
        // 设置coverView的y坐标
        let coverViewY = (bounds.height - coverViewHeight) * 0.5
        
        // 如果TitleView上面的标题可以滚动时
        if titleStyle.isScrollEnable {
            
            // 设置coverView的x坐标
            coverViewX -= titleStyle.coverViewMargin
            
            // 设置coverView的宽度
            coverViewWidth += titleStyle.coverViewMargin * 2
        }
        
        // 设置coverView的frame
        coverView.frame = CGRect(x: coverViewX, y: coverViewY, width: coverViewWidth, height: coverViewHeight)
        
        // 设置coverViewlayer的裁剪半径
        coverView.layer.cornerRadius = titleStyle.coverViewRadius
        
        // 对coverView的layer进行裁剪
        coverView.layer.masksToBounds = true
    }
}



/**
 *  当我们点击TitleView上面的titleLabel时，下面这些代码会对TitleView上面的事件做相应的处理
 */
// MARK: - 事件监听
extension TitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGesture: UITapGestureRecognizer) {
        
        // 从手势中取出当前被点击的titleLabel
        guard let selectedTitleLabel = tapGesture.view as? UILabel else { return }
        
        // 取出上一个titleLabel
        let previousTitleLabel = titleLabels[selectedTitleLabelIndex]
        
        
        
        
        
        // 点击titleLabel，切换被选中标题文字的颜色
        switchTitleTextColor(selectedTitleLabel, previousTitleLabel)
        
        
        
        
        
        // 点击titleLabel，让其自动移动到中间合适的位置
        setTitleScrollContentOffset()
        
        
        
        
        
        // 如果需要标题下面的滚动指示器
        if titleStyle.isShowScrollSlide {
            
            // 当titleLabel被点击以后，让指示器移动到合适的位置
            setScrollSlideFrame(selectedTitleLabel)
        }
        
        
        
        
        
        // 如果需要遮盖效果
        if titleStyle.isShowCoverView {
            
            // 当点击titleLabel以后，让遮盖移动到对应的位置
            setCoverViewFrame(selectedTitleLabel)
        }
        
        
        
        
        // 如果需要对被选中的titleLabel进行缩放
        if titleStyle.isNeedScale {
            
            // 让被选中的titleLabel放大，取消被选中的titleLabel复原
            scaleSelectedTitleLabel(previousTitleLabel, selectedTitleLabel)
        }
    }
    
    /// 切换文字颜色
    private func switchTitleTextColor(_ selectedTitleLabel: UILabel, _ previousTitleLabel: UILabel) {
        
        
        
        // 修复bug：当重复点击同一个titleLabel时，也就是当前titleLabel的tag和selectedTitleLabelIndex相等时，不用执行文字颜色的切换代码
        if selectedTitleLabelIndex == selectedTitleLabel.tag { return }
        
        // 切换当前被选中titleLabel和上一个titleLabel文字的颜色
        selectedTitleLabel.textColor = titleStyle.selectedTextColor
        previousTitleLabel.textColor = titleStyle.normalTextColor
        
        // 将当前被选中titleLabel的下标值保存起来
        selectedTitleLabelIndex = selectedTitleLabel.tag
        
        
        /******** 通过代理，将当前被点击titleLabel的下标值传递出去 ********/
        delegate?.titleView(self, selectedTitleLabelIndex: selectedTitleLabelIndex)
    }
    
}


/**
 *  当我们滑动子控制器时，下面的代码会对TitleView中的titleLabel进行相应的处理
 */
// MARK: - 对外暴露的方法
extension TitleView {
    
    /// 获取从ContentViewDelegate中传递过来的当前子控制器的下标
    func getSelectedChildVcIndex(_ childVcIndex: Int) {
        
        // 取出与当前子控制器对应的titleLabel
        let selectedTitleLabel = titleLabels[childVcIndex]
        
        // 取出上一个titleLabel
        let previousTitleLabel = titleLabels[selectedTitleLabelIndex]
        
        // 修复bug：当我们滑动子控制器，但是又没有完全划过时，也就是当前子控制器的tag和selectedTitleLabelIndex相等时，不用执行文字颜色的切换代码
        if selectedTitleLabelIndex == childVcIndex { return }  // selectedTitleLabelIndex == selectedTitleLabel.tag
        
        // 切换文字颜色
        selectedTitleLabel.textColor = titleStyle.selectedTextColor
        previousTitleLabel.textColor = titleStyle.normalTextColor
        
        // 记录下标值
        selectedTitleLabelIndex = childVcIndex
        
        
        
        
        // 让titleLabel自动移动到中间合适的位置
        setTitleScrollContentOffset()
        
        
        // 如果需要标题下面的滚动指示器
        if titleStyle.isShowScrollSlide {
            
            // 让指示器移动到合适的位置
            setScrollSlideFrame(selectedTitleLabel)
        }
        
        
        
        
        
        // 如果需要遮盖效果
        if titleStyle.isShowCoverView {
            
            // 让遮盖移动到对应的位置
            setCoverViewFrame(selectedTitleLabel)
        }
        
        
        
        
        // 如果需要对被选中的titleLabel进行缩放
        if titleStyle.isNeedScale {
            
            // 让被选中的titleLabel放大，取消被选中的titleLabel复原
            scaleSelectedTitleLabel(previousTitleLabel, selectedTitleLabel)
        }
    }
}



/**
 *  点击TitleView中的titleLabel，或者滑动子控制器时，下面的代码会对事件作出相应的处理
 */
// MARK: - 公共的事件监听处理方法
extension TitleView {
    
    /// 点击titleLabel，让其自动移动到中间合适的位置
    fileprivate func setTitleScrollContentOffset() {
        
        // 如果TitleView不需要滚动，直接返回
        guard titleStyle.isScrollEnable else { return }
        
        // 取出当前选中的titleLabel
        let selectedTitleLabel = titleLabels[selectedTitleLabelIndex]
        
        // 计算x的偏移量(被选中titleLabel中心点x的坐标 - titleScrollView宽度的一半)
        var offsetX = selectedTitleLabel.center.x - titleScrollView.bounds.width * 0.5
        
        // 对左边临界值进行判断
        if offsetX < 0 {
            offsetX = 0
        }
        /**
         *  以最左边的一个titleLabel为例，它中心点x的坐标肯定比屏幕宽度的一半要小，如果用它
         *  去减屏幕宽度的一半，所得结果肯定小于0。但是它是不需要偏移的。实际上，所有offsetX
         *  小于0的titleLabel都不需要进行偏移。
         */
        
        // 对右边临界值进行判断
        if offsetX > (titleScrollView.contentSize.width - titleScrollView.bounds.width) {
            offsetX = titleScrollView.contentSize.width - titleScrollView.bounds.width
        }
        /**
         *  还是以最右边的一个titleLabel为例，我们假设它往左边偏移，并且已经完全显现出来了，那
         *  么，它此时能往左边滚动的最大偏移量是多少呢？应该是整个titleScrollView的contentSize
         *  减去整个屏幕的宽度，这个已经是极限了，偏移量不能再比它更大了。如果偏移量在此基础上继续
         *  增大，就会发生有右边的titleLabel远离右边框的事情。
         */
        
        // 重新设置offset
        titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    
    ///  当titleLabel被点击以后，让指示器移动到合适的位置
    fileprivate func setScrollSlideFrame(_ selectedTitleLabel: UILabel) {
        
        // 修改当前被点击(选中)titleLabel指示器scrollSlide的x坐标和宽度，并执行动画
        UIView.animate(withDuration: 0.15, animations: {
            
            // 和当前被选中titleLabel的中心点x坐标相同
            self.scrollSlide.center.x = selectedTitleLabel.center.x
            
            // 计算当前被选中titleLabel标题文本的宽度
            let width = (selectedTitleLabel.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: self.titleStyle.titleFont], context: nil).width
            
            // 和当前被选中titleLabel标题文本的宽度相同
            self.scrollSlide.frame.size.width = width
        })
    }
    
    
    /// 当点击titleLabel以后，让遮盖移动到对应的位置
    fileprivate func setCoverViewFrame(_ selectedTitleLabel: UILabel) {
        
        // 重新计算coverView的x坐标
        let coverViewX = titleStyle.isScrollEnable ? (selectedTitleLabel.frame.origin.x - titleStyle.coverViewMargin) : selectedTitleLabel.frame.origin.x
        
        // 重新计算coverView的宽度
        let coverViewWidth = titleStyle.isScrollEnable ? (selectedTitleLabel.frame.width + titleStyle.coverViewMargin * 2) : selectedTitleLabel.frame.width
        
        // 修改coverView的x坐标和宽度，并且执行动画
        UIView.animate(withDuration: 0.15, animations: {
            
            // 修改coverView的x坐标
            self.coverView.frame.origin.x = coverViewX
            
            // 修改coverView的宽度
            self.coverView.frame.size.width = coverViewWidth
        })
    }
    
    
    /// 让被选中的titleLabel放大，取消被选中的titleLabel复原
    fileprivate func scaleSelectedTitleLabel(_ previousTitleLabel: UILabel, _ selectedTitleLabel: UILabel) {
        
        // 对上一个titleLabel执行复原操作
        previousTitleLabel.transform = CGAffineTransform.identity
        
        // 对当前被点击(选中)的titleLabel执行缩放操作
        selectedTitleLabel.transform = CGAffineTransform(scaleX: titleStyle.scaleRange, y: titleStyle.scaleRange)
    }
}
