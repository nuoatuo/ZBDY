//
//  XZPageTitleView.swift
//  ZBDY
//
//  Created by 古今 on 2016/11/18.
//  Copyright © 2016年 夜风易冷. All rights reserved.
//

import UIKit

//滚动条高度
private let kScrollLineViewH : CGFloat = 2.0

class XZPageTitleView: UIView {

    // MARK: - 定义属性
    fileprivate var titlesArray : [String]
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLabelsArray : [UILabel] = [UILabel]()
    fileprivate lazy var bgScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLineView : UIView = {
        let scrollLineView = UIView()
        scrollLineView.backgroundColor = UIColor.orange
        return scrollLineView
    }()
    
    
 // MARK: - 自定义构造函数
    init(frame: CGRect, titlesArray : [String]) {
         self.titlesArray = titlesArray
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    //swift语法:重写或自定义构造函数必须重写下面的函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension XZPageTitleView {
    
    //设置UI界面
    fileprivate func setupUI(){
        
        //1. 添加UIScrollView
        addSubview(bgScrollView)
        bgScrollView.frame = bounds
        
        //2. 添加title对应的label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    //添加title对应的label
    private func setupTitleLabels() {
        
        //0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titlesArray.count)
        let labelH : CGFloat = frame.height - kScrollLineViewH
        let labelY : CGFloat = 0.0
        for (index, title) in titlesArray.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //3.设置lable的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到bgScrollView中
            bgScrollView.addSubview(label)
            titleLabelsArray.append(label)
        }
    }
    
    //设置底线和滚动的滑块
    private func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLineView
        //2.1获取第一个label
        guard let firstLabel = titleLabelsArray.first else { return }
        firstLabel.textColor = UIColor.orange
        
        //2.2设置scrollLineView.frame的属性
        bgScrollView.addSubview(scrollLineView)
        scrollLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineViewH, width: firstLabel.frame.width, height: kScrollLineViewH)
    }
}


