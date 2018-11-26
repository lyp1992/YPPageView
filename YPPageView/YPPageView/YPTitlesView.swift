//
//  YPTitlesView.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2018/11/22.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

protocol YPTitleViewDelegate : class {
    func titleView(_ titleView : YPTitlesView, currentIndex : Int)
}

class YPTitlesView: UIView {

//    weak 只能用来修饰对象
    weak var delegate : YPTitleViewDelegate?
    
    typealias ColorRGB = (red : CGFloat, green : CGFloat, blue : CGFloat)
    fileprivate  var style : YPPageStyle
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    fileprivate lazy var selectRGB : ColorRGB = self.style.selectColor.getRGB()
    fileprivate lazy var normalRGB : ColorRGB = self.style.normalColor.getRGB()
    fileprivate lazy var deltaRGB : ColorRGB = {
        let deltaR = self.selectRGB.red - self.normalRGB.red
        let detlaG = self.selectRGB.green - self.normalRGB.green
        let deltaB = self.selectRGB.blue - self.normalRGB.blue
        return (deltaR,detlaG,deltaB)
    }()
    
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
        guard  targetLabel.tag != currentIndex else {
            return
        }
        
//        取出之前的label
        let sourceLabel = titleLabels[currentIndex]
//        改变颜色
        sourceLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
//        记录当前点击的label
        currentIndex = targetLabel.tag
//        让点击的label居中
        addJustPosition(targetLabel)
       delegate?.titleView(self, currentIndex: currentIndex)
    }
    
    private func addJustPosition(_ targetLabel : UILabel){
// 1.计算距离中心的offset
       var offSetX = targetLabel.center.x - self.bounds.size.width * 0.5
        if offSetX <= 0 {
            offSetX = 0
        }
        if offSetX > scrollView.contentSize.width - scrollView.bounds.width {
            offSetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        
        scrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
        
    }
}

extension YPTitlesView : YPContentViewDelegate{
    func contentView(_ contentView: YPContentView, inIndex: Int) {
        currentIndex = inIndex
        addJustPosition(titleLabels[currentIndex])
    }
    
    func contentView(_ contentView: YPContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
//        获取label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[sourceIndex]
        
//        颜色渐变
        sourceLabel.textColor = UIColor(r: selectRGB.red - progress * deltaRGB.red, g: selectRGB.green - progress * deltaRGB.green, b: selectRGB.blue - progress * deltaRGB.blue, alpha: 1)
        targetLabel.textColor = UIColor(r: normalRGB.red + progress * deltaRGB.red, g: normalRGB.green + progress * deltaRGB.green, b: normalRGB.blue + progress * deltaRGB.blue, alpha: 1)
        
    }
}
