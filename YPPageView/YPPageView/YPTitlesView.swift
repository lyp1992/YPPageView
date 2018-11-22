//
//  YPTitlesView.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2018/11/22.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

class YPTitlesView: UIView {

    fileprivate  var style : YPPageStyle
    fileprivate var titles : [String]
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds;
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    init(frame : CGRect,style : YPPageStyle, titles : [String]) {
        self.style = style
        self.titles = titles
        super.init(frame: frame)
        setUPUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code) has not been immplement")
    }
}

extension YPTitlesView{
    
   fileprivate func setUPUI() {
        addSubview(scrollView)
    
     setupTitleLabels()
     setupTitleFrame()
    }
    
    private func setupTitleFrame() {
        //        定义常量
        let labelH = style.titleHeight
        let labelY : CGFloat = 0
        var labelW : CGFloat = 0
        var labelX : CGFloat = 0
        
        let count = titleLabels.count
        for (i,titleLabel) in titleLabels.enumerated() {
            if style.isScrollEnable {//可以滚动
                labelW = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedStringKey : titleLabel.font], context: nil).width
                labelX = i == 0 ? style.titleMargin * 0.5 : (titleLabels[i-1].frame.maxX + style.titleMargin)
            } else {//不可以滚动
                labelW = bounds.width / CGFloat(count)
                labelX = labelW * CGFloat(i)
            }
            titleLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        
        if style.isScrollEnable {
            scrollView.contentSize.width = titleLabels.last!.frame.maxX + style.titleMargin * 0.5
        }
        
    }
    
    private func setupTitleLabels() {

        for (i,title) in titles.enumerated() {
            let label = UILabel()
            
//            设置label的属性
            label.tag = i
            label.text = title
            label.textColor = i == 0 ?style.selectColor :style.normalColor
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: style.fontSize)
            
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            label.isUserInteractionEnabled = true
            
        }
    }
    
}

extension YPTitlesView{

    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
//        检验label
        guard let targetLabel = tapGes.view as? UILabel  else {
            return
        }
        
        print(targetLabel.tag)
    }
    
}
