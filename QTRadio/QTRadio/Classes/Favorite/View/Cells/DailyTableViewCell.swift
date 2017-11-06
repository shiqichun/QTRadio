//
//  DailyTableViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/6.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 通过xib的方式来实现今日推荐tableView的cell

import UIKit

/// cell距离屏幕左右的间距
private let kMarigin: CGFloat = 10

class DailyTableViewCell: UITableViewCell {
    
    // 收藏按钮距离屏幕左边间距
    @IBOutlet weak var collectLeft: NSLayoutConstraint!
    
    // 收听按钮距离屏幕右边间距
    @IBOutlet weak var listenRight: NSLayoutConstraint!
    
    // 顶部推荐标题
    @IBOutlet weak var topTitle: UILabel!
    
    // 推荐专辑配图
    @IBOutlet weak var myImageView: UIImageView!
    
    // 正文标题
    @IBOutlet weak var titleLabel: UILabel!
    
    // 分类标题
    @IBOutlet weak var categoryTitle: UILabel!
    
    // 播放次数统计标题
    @IBOutlet weak var playCountLabel: UILabel!
    
    // 正文描述控件
    @IBOutlet weak var myTextLabel: UILabel!
    
    
    /// 监听收藏按钮的点击
    @IBAction func collectBtnClick(_ sender: Any) {
        
        print("DailyTableViewCell---collectBtnClick")
    }
    
    
    /// 监听收听按钮的点击
    @IBAction func listenBtnClick(_ sender: Any) {
        
        print("DailyTableViewCell---listenBtnClick")
    }
    
    
    
    
    // 重写frame，调整cell上下左右的间距
    override var frame: CGRect{
        
        didSet {
            var newFrame = frame
            newFrame.origin.x += kMarigin
            newFrame.size.width -= 2 * kMarigin
            newFrame.origin.y += kMarigin
            newFrame.size.height -= kMarigin
            super.frame = newFrame
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 统一设置UI界面
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 当一个cell被重用时会调用这个方法
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 因为cell是有重用机制的
        // 所以，尽管后面会再给控件
        // 赋值，但是最好在赋值之前
        // 先把所有控件的数据都清空
        topTitle.text = nil
        titleLabel.text = nil
        categoryTitle.text = nil
        playCountLabel.text = nil
        myImageView.image = nil
        myTextLabel.text = nil
    }
    
}


// MARK: - 统一设置UI界面
extension DailyTableViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的圆角
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        // 修改顶部标题的颜色
        topTitle.textColor = UIColor(r: 190, g: 158, b: 105)
    }
}
