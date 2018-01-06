//
//  TitleView.swift
//  PageView
//
//  Created by Enrica on 2018/1/4.
//  Copyright © 2018年 Enrica. All rights reserved.
//

import UIKit

/// TitleView的代理协议
protocol TitleViewDelegate: class {
    
    /// 通过代理方法，将当前被点击label的下标值传递出去
    func titleView(_ titleView: TitleView, selectedLabelIndex index: Int)
}

class TitleView: UIView {
    
    // MARK: - 对外暴露的属性
    
    /// 代理属性
    weak var delegate: TitleViewDelegate?
    

    // MARK: - 私有属性
    
    /// 保存从containerView中传递过来的标题titles
    fileprivate var titles: [String]
    
    /// 保存从containerView中传递过来的标题样式initializeSetting
    fileprivate var initializeSetting: InitializeSettings
    
    /// 保存当前被选中label的下标值(默认初始值由外部提供)
    fileprivate var selectedLabelIndex: Int
    
    /// 用于保存label的宽度
    fileprivate var labelWidth: CGFloat = 0
    
    
    // MARK: - 懒加载属性
    
    /// 懒加载scrollView控件
    fileprivate lazy var scrollView: UIScrollView = {
        
        // 创建scrollView
        let scrollView = UIScrollView()
        
        // 设置scrollView的frame
        scrollView.frame = self.bounds
        
        // FIXME: - 设置scrollView的背景颜色
        scrollView.backgroundColor = self.initializeSetting.titleBackgroundColor  // self.initializeSetting.titleBackgroundColor
        
        
        // FIXME: - 适配iPhone X
        if #available(iOS 11.0, *) {

            // 消除底部指示器被遮挡的情况
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        
        // 设置titleScrollView的相关属性
        scrollView.showsVerticalScrollIndicator = false  // 禁用垂直滚动条
        scrollView.showsHorizontalScrollIndicator = false  // 禁用水平滚动条
        scrollView.scrollsToTop = false  // 禁用触摸状态栏自动回到顶部的功能
        scrollView.bounces = false  // 禁用弹力效果
        
        return scrollView
    }()
    
    /// 保存标题控件label，以方便在设置其frame时使用
    fileprivate lazy var labels: [UILabel] = [UILabel]()
    
    /// 对titleView和contentView之间的分割线进行懒加载
    fileprivate lazy var dividingLine: UIView = {
        
        // 创建分割线
        let dividingLine = UIView()
        
        // 设置分割线的frame
        dividingLine.frame = CGRect(x: 0, y: self.bounds.height - self.initializeSetting.dividingLineHeight, width: self.bounds.width, height: self.initializeSetting.dividingLineHeight)
        
        // 设置dividingLine的背景颜色
        dividingLine.backgroundColor = self.initializeSetting.dividingLineBackgroundColor
        
        return dividingLine
    }()
    
    /// 对选中标题指示器进行懒加载
    fileprivate lazy var titleIndicator: UIView = {
        
        // 创建标题指示器，并且设置其frame为被选中label的frame
        let titleIndicator = UIView(frame: labels[selectedLabelIndex].frame)
        
        // 取出被选中label的标题
        let text = titles[selectedLabelIndex]
        
        // 计算被选中标题文字的高度
        let textSize = (text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : initializeSetting.titleFont], context: nil)
        
        // 修改标题指示器x的值
        if initializeSetting.isScrollEnable {
            
            // 当标题控制器需要滚动时，指示器的初始坐标为：选中label最小的x值 + (选中label文字宽度 - 指示器宽度) * 0.5
            titleIndicator.frame.origin.x = labels[selectedLabelIndex].frame.minX + (textSize.width - initializeSetting.titleIndicatorWidth) * 0.5
            
        } else {
            
            // 当标题指示器不需要滚动时，指示器的初始坐标为：选中label最小的x值 + (选中label的宽度 - 指示器宽度) * 0.5
            titleIndicator.frame.origin.x = labels[selectedLabelIndex].frame.minX + (labelWidth - initializeSetting.titleIndicatorWidth) * 0.5
            
        }
        
        
        // 修改标题指示器的y值
        // (titleView高度 - 文字的高度) * 0.5 + 文字的高度 + (titleView高度 - 文字的高度) * 0.25 - 指示器高度 * 0.5
        titleIndicator.frame.origin.y = initializeSetting.titleViewHeight * 0.75 + textSize.height * 0.25 - initializeSetting.titleIndicatorHeight * 0.5
        
        // 修改标题指示器的宽度
        titleIndicator.frame.size.width = initializeSetting.titleIndicatorWidth
        
        // 修改标题指示器的x高度
        titleIndicator.frame.size.height = initializeSetting.titleIndicatorHeight
        
        // 设置标题指示器的背景颜色
        titleIndicator.backgroundColor = initializeSetting.titleIndicatorBackgroundColor
        
        // 设置标题指示器的圆角
        titleIndicator.layer.cornerRadius = initializeSetting.titleIndicatorHeight * 0.5
        
        return titleIndicator
    }()

    
    // MARK: - 自定义构造函数
    
    /// 用于创建容纳子控制器标题的titleView
    /// - 参数frame：表示titleView的frame
    /// - 参数titles：表示所有子控制器的标题
    /// - 参数initializeSetting：表示外部传递过来的标题的初始化设置
    init(frame: CGRect, titles: [String], initializeSetting: InitializeSettings) {
        
        // 初始化私有属性
        self.titles = titles
        self.initializeSetting = initializeSetting
        self.selectedLabelIndex = initializeSetting.defaultIndex
        
        // 调用父类的构造函数
        super.init(frame: frame)
        
        // 设置UI界面(添加标题label、遮盖coverView和指示器scrollSlide)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension TitleView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 将scrollView添加到titleView上面
        addScrollView()
        
        // 将标题控件添加到scrollView上面
        addLabels()
        
        // 设置label的frame
        setupLabelFrame()
        
        // 添加分割线
        addDividingLine()
        
        // 如果需要选中标题指示条
        if initializeSetting.showsTitleIndicator {
            
            // 添加标题指示器
            addTitleIndicator()
        }
    }
    
    /// 创建scrollView，然后再将其添加到titleView上面。
    /// 因为有些情况下，标题是可以滚动的，因此不能将标题直
    /// 接添加到titleView上面，而是应该将标题添加到一个
    /// scrollView上面，然后再将这个scrollView添加到
    /// titleView上面，最后再根据实际需要来控制器这个
    /// scrollView是否需要滚动
    private func addScrollView() {
        
        // 将scrollView添加到titleView上面
        addSubview(scrollView)
    }
    
    /// 将标题控件添加到scrollView上面
    private func addLabels() {
        
        // 遍历标题数组titles，根据标题的个数来创建与之对应的标题控件
        // 因为后面涉及到需要给每个label设置frame，因此在遍历的时候
        // 最好顺便个每个label绑定一个tag
        for (index, title) in titles.enumerated() {
            
            // 创建标题控件label
            let label = UILabel()
            
            // FIXME: - 设置标题控件label的背景颜色
            label.backgroundColor = initializeSetting.titleBackgroundColor  // initializeSetting.titleBackgroundColor
            
            // 将标题设置到标题控件label上面去
            label.text = title
            
            // 设置标题在标题控件label中居中显示
            label.textAlignment = .center
            
            // 设置标题的字体大小
            label.font = initializeSetting.titleFont
            
            // 给标题控件label绑定tag
            label.tag = index
            
            // 首先需要对defaultIndex的合法性进行校验，defaultIndex的值
            // 只要是不在0..<titles.count这个范围之内，它都是非法的
            if initializeSetting.defaultIndex < 0 || initializeSetting.defaultIndex >= titles.count {
                initializeSetting.defaultIndex = 0
            }
            
            // 设置选中标题和非选中标题的文字颜色
            label.textColor = index == initializeSetting.defaultIndex ? initializeSetting.selectedTextColor : initializeSetting.normalTextColor
            
            // 设置label的frame。因为label的frame是由标题的具体个数
            // 来决定的，因此设置起来会比较麻烦，而且代码量也会很多。为此，
            // 这里把设置label尺寸的代码单独抽出来作为一个独立的方法。这
            // 样一来，就需要把label保存到一个数组中，以供在另外一个独立
            // 代码块中进行使用
            labels.append(label)
            
            // 将label添加到scrollView上面
            scrollView.addSubview(label)
            
            
            // 给label添加手势。因为UILabel的用户交互默认是被禁止的，因此需要手动开启
            label.isUserInteractionEnabled = true
            
            // 创建tap(点击)手势
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(TitleView.labelClick(_:)))
            
            // 将手势添加到label上面
            label.addGestureRecognizer(tapGestrue)
        }
    }
    
    /// 给label设置frame
    private func setupLabelFrame() {
        
        // label的x值
        var labelX: CGFloat = 0
        
        // label的y值
        let labelY: CGFloat = 0
        
        // label的宽度
        //var labelWidth: CGFloat = 0
        
        // label的高度
        let labelHeight = initializeSetting.titleViewHeight
        
        // label的个数
        let labelCount: Int = labels.count
        
        // 遍历数组labels，从中取出标题控件label
        for (index, label) in labels.enumerated() {
            
            // 判断是否需要滚动标题
            if initializeSetting.isScrollEnable {
                
                /**
                 * 如果标题是可以滚动的，那么label的frame计算起来就稍微麻烦一点，以计算label的宽度为例：
                 *  首先，需要人为定义一个label之间的间距，这个最好是由外部的initializeSetting来决定；
                 *  其次，需要取出label上面所展示的文字，然后再根据具体的文字来计算label的宽度
                 */
                
                // 根据label上面文字的字体大小来计算label的宽度，并且将其保存起来
                labelWidth = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: initializeSetting.titleFont], context: nil).width
                
                
                
                /**
                 *  计算label的x值时，也需要分情况考虑：
                 *      首先，第一个label，也就是下标值为0的label，它距离最左边的间距最好是半个labelMargin；
                 *      其次，当前label的x值应该是与上一个label最大的x值相关的。
                 */
                
                // 计算label的x值
                if index == 0 {
                    
                    // 先计算下标为0的label的x值
                    // 下标为0的label距离最左边屏幕的间距应该为半个labelMargin
                    labelX = initializeSetting.labelMargin * 0.5
                    
                } else {
                    
                    // 再计算下标不为0的label的x值
                    // 先取出上一个label(index - 1就是上一个label的下标值)
                    // 这里不会发生数组越界，因为我们已经排除了index为0的情况
                    let previousLabel = labels[index - 1]
                    
                    // 再来计算当前label的x值(label的x值 = 上一个label最大的x值 + label之间的间距)
                    labelX = previousLabel.frame.maxX + initializeSetting.labelMargin
                }
                
                
            } else {
                
                /**
                 * 如果标题不可以滚动，那么label的frame就比较好计算了：
                 *  label的宽度 = titleView的宽度 / 标题的个数
                 *  label的x值 = label宽度 * 与之对应的下标值
                 */
                
                // 计算label的宽度
                labelWidth = bounds.width / CGFloat(labelCount)
                
                // 计算label的x值
                labelX = labelWidth * CGFloat(index)
            }
            
            // 根据label的x值、y值、宽度和高度来设置label的frame
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
        
        /// 最后，不要忘记，当标题可以滚动时，需要设置scrollView的可滚动区域
        /// 也就是需要设置scrollView的contentSize
        if initializeSetting.isScrollEnable {
            
            // contentSize = 最后一个标题最大的x值 + label之间间距的一半
            scrollView.contentSize = CGSize(width: labels.last!.frame.maxX + initializeSetting.labelMargin * 0.5, height: 0)
        }
        
    }
    
    /// 给titleView和contentView添加分割线
    private func addDividingLine() {
        
        // 因为分割线是不需要滚动的，因此可以将其直接添加到titleView上面
        addSubview(dividingLine)
    }
    
    /// 添加标题指示器
    private func addTitleIndicator() {
        
        // 因为标题指示器是需要跟随标题一起滚动的，所以需要
        // 将titleIndicator添加到scrollView上面
        scrollView.addSubview(titleIndicator)
    }
}


// MARK: - 事件监听
extension TitleView {
    
    /// 监听label的手势点击。点击label以后，需要做以下几件事情：
    /// - 切换label上面文字的颜色；
    /// - 切换子控制器；
    /// - 如果需要指示器，就要让指示器滚动到指定的位置；
    /// - 如果需要遮盖，就要让遮盖移动到指定的位置；
    /// - 如果需要对标题的字体大小进行缩放，就要让标题按照要求进行缩放
    @objc fileprivate func labelClick(_ tapGesture: UITapGestureRecognizer) {
        
        // 从手势中取出当前被选中的label
        guard let selectedLabel = tapGesture.view as? UILabel else { return }
        
        // 同时取出上一个被选中的label
        let previousLabel = labels[selectedLabelIndex]
        
        /** 第1步：切换文字颜色 */
        // 切换label上面被选中文字的颜色。设置当前选中label的文字颜色为selectedTextColor
        // 还原上一个被选中label的文字颜色为normalTextColor。由于切换标题文字颜色的代码要在多处
        // 用到，所以这里将其单独抽取出来作为一个独立的方法
        changeTitleColor(selectedLabel, previousLabel)
        
        /** 第2步：如有必要，则需要让标题指示器移动到指定的位置 */
        // 如果需要标题指示器，那么当我们点击label时，标题指示器应该更改位置并执行相应的动画
        if initializeSetting.showsTitleIndicator {
            
            // 让标题指示器移动到指定的位置
            changeIndecatorCenterX(selectedLabel)
        }
        
        /** 第3步：如有必要，则需要对标题字体执行缩放 */
        // 如果需要对选中的标题进行缩放
        if initializeSetting.needsToScale {
            
            // 对选中的标题执行缩放
            scaleSelectedTitle(previousLabel, selectedLabel)
        }
        
        /** 第4步：同步滚动子控制器 */
        // 当我们点击titleView上面的标题时，让contentView中的子控制器同步滚动到
        // 正确的位置，为此，我们需要将当前选中label的index传递出去。但是，titleView
        // 和contentView并没有直接的联系。不过，好在titleView和contentView都和
        // 它们的父控件containerView有联系。因此，我们可以把titleView中当前选中
        // label的index传递给containerView，然后再让containerView传递给contentView
        delegate?.titleView(self, selectedLabelIndex: selectedLabelIndex)
    }
    
    /// 切换标题文字的颜色
    private func changeTitleColor(_ selectedLabel: UILabel, _ previousLabel: UILabel) {
        
        // 修复bug：当重复点击同一个label时，也就是当前label的tag和selectedLabelIndex相等时，不用执行文字颜色的切换代码
        if selectedLabelIndex == selectedLabel.tag { return }
        
        // 切换当前被选中label和上一个label文字的颜色
        selectedLabel.textColor = initializeSetting.selectedTextColor
        previousLabel.textColor = initializeSetting.normalTextColor
        
        // 将当前被选中label的下标值保存起来
        selectedLabelIndex = selectedLabel.tag
        
        // 点击label之后，根据实际需要，让label自动移动到合适的位置
        // 只有当TitleView上面的标题需要滚动时，才需要让label滚动到合适的位置
        if initializeSetting.isScrollEnable {
            autoChangeLabelPosition()
        }
    }
    
    /// 点击label之后，根据实际需要，让label自动移动到合适的位置
    fileprivate func autoChangeLabelPosition() {
        
        // 如果TitleView上面的标题不需要滚动，则直接返回
        //guard initializeSetting.isScrollEnable else { return }
        
        // 取出当前选中的label
        let selectedLabel = labels[selectedLabelIndex]
        
        // 计算x的偏移量(被选中label中心点x的坐标 - scrollView宽度的一半)
        var offsetX = selectedLabel.center.x - scrollView.bounds.width * 0.5
        
        // 对左边临界值进行判断
        if offsetX < 0 {
            
            
            /**
             *  以最左边的一个label为例，它中心点x的坐标肯定比屏幕宽度的一半要小，如果用它
             *  去减屏幕宽度的一半，所得结果肯定小于0。但是它是不需要偏移的。实际上，所有
             *  offsetX小于0的label都不需要进行偏移。
             */
            offsetX = 0
        }
        
        // 对右边临界值进行判断
        if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
            
            
            /**
             *  还是以最右边的一个offsetX为例，我们假设它往左边偏移，并且已经完全显现出来了，那
             *  么，它此时能往左边滚动的最大偏移量是多少呢？应该是整个scrollView的contentSize
             *  减去整个屏幕的宽度，这个已经是极限了，偏移量不能再比它更大了。如果偏移量在此基础上
             *  继续增大，就会发生有右边的label远离右边框的事情。
             */
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        // 重新设置offset
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    /// 移动标题指示器的位置到指定的位置
    private func changeIndecatorCenterX(_ selectedLabel: UILabel) {
        
        // 修改被选中label指示器titleIndicator的x坐标并执行动画
        UIView.animate(withDuration: 0.15, animations: {
            
            // 和当前被选中label的中心点x坐标相同
            self.titleIndicator.center.x = selectedLabel.center.x
        })
    }
    
    /// 对标题进行缩放
    private func scaleSelectedTitle(_ previousLabel: UILabel, _ selectedLabel: UILabel) {
        
        // 对上一个label的标题执行复原操作
        previousLabel.transform = CGAffineTransform.identity
        
        // 对选中label的标题执行缩放操作
        selectedLabel.transform = CGAffineTransform(scaleX: initializeSetting.scaleRange, y: initializeSetting.scaleRange)
    }
}



// MARK: - 对外暴露的方法
extension TitleView {
    
    /// 接收从ContentView中传递过来的下标值，执行相应的操作
    func scrollLabel(toIndex: Int) {
        
        // 取出与当前子控制器对应的label
        let selectedLabel = labels[toIndex]
        
        // 取出上一个label
        let previousLabel = labels[selectedLabelIndex]
        
        // 修复bug：当我们滑动子控制器，但是又没有完全划过时，也就是当前子控制器的tag
        // 和selectedLabelIndex相等时，不用执行文字颜色的切换代码
        if selectedLabelIndex == toIndex { return }  // selectedLabelIndex == selectedLabel.tag
        
        // 切换文字颜色
        selectedLabel.textColor = initializeSetting.selectedTextColor
        previousLabel.textColor = initializeSetting.normalTextColor
        
        // 记录下标值
        selectedLabelIndex = toIndex
        
        
        // 让label自动移动到中间合适的位置
        autoChangeLabelPosition()
        
        
        // MARK: - 这里需要重写指示器滚动的动画(毛毛虫动画)
        // 如果需要标题下面的滚动指示器
        if initializeSetting.showsTitleIndicator {
            
            // 让指示器移动到合适的位置
            changeIndecatorCenterX(selectedLabel)
        }
        
        
        // 如果需要对被选中的label进行缩放
        if initializeSetting.needsToScale {
            
            // 让被选中的titleLabel放大，取消被选中的titleLabel复原
            scaleSelectedTitle(previousLabel, selectedLabel)
        }
    }
}
