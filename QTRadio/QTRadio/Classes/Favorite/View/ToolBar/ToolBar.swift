//
//  ToolBar.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

class ToolBar: UIView {

    // MARK: - 懒加载属性
    
    /// 横线
    fileprivate lazy var horizonLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    /// 竖线
    fileprivate lazy var verticalLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    /// 收藏按钮
    fileprivate lazy var collectBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("收藏", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitleColor(.black, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(collectBtnClick), for: .touchUpInside)
        sizeToFit()
        return btn
    }()
    
    /// 收听按钮
    fileprivate lazy var listenBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("收听", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitleColor(.black, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(listenBtnClick), for: .touchUpInside)
        sizeToFit()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 设置UI界面
extension ToolBar {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加横着的分割线
        addSubview(horizonLine)
        
        // 添加竖着的分割线
        addSubview(verticalLine)
        
        // 添加收藏按钮
        addSubview(collectBtn)
        
        // 添加收听按钮
        addSubview(listenBtn)
    }
    
    
    override func layoutSubviews() {
        
        // 布局横着的分割线
        horizonLine.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.4)
        }
        
        // 布局竖线的位置
        verticalLine.snp.makeConstraints { (make) in
            make.top.equalTo(horizonLine.snp.bottom)
            make.width.equalTo(0.4)
            make.bottom.equalTo(self)
            make.left.equalTo(self).offset(bounds.width * 0.5)
        }
        
        // 布局收藏按钮
        collectBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(verticalLine.snp.right).offset(-bounds.width * 0.25)
            make.centerY.equalTo(self)
        }
        
        // 布局收听按钮的位置
        listenBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.right).offset(-bounds.width * 0.25)
            make.centerY.equalTo(self)
        }
    }
}




// MARK: - 监听事件的点击
extension ToolBar {
    
    /// 监听收藏按钮的点击
    @objc fileprivate func collectBtnClick() {
        
        print("ToolBar---collectBtnClick")
    }
    
    /// 监听收藏按钮的点击
    @objc fileprivate func listenBtnClick() {
        
        print("ToolBar---listenBtnClick")
    }
}
