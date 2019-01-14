//
//  ViewController.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2019/1/14.
//  Copyright © 2019年 LYP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let style = YPPageStyle()
        style.isScrollEnable = true
        style.isBottomLineShow = true
        style.isShowCoverView = true
        
        
        let titles = ["推荐", "游戏游戏游戏", "热门游戏", "趣玩游", "娱乐", "热门游戏2", "趣玩游2", "娱乐2","娱乐3"]
        
        var childVCs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/256.0, green: CGFloat(arc4random_uniform(256))/256.0, blue: CGFloat(arc4random_uniform(256))/256.0, alpha: 1.0)
            childVCs.append(vc)
        }
         let pageVFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        let pageView = YPPageView(frame: pageVFrame, style: style, titles: titles, childVCs: childVCs, parentVC: self)
        view.addSubview(pageView)
    }


}

