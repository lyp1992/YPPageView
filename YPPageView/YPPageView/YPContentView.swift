//
//  YPContentView.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2018/11/22.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

class YPContentView: UIView {

    var childVCs : [UIViewController]

    init(frame : CGRect,childVCs : [UIViewController]) {
        self.childVCs = childVCs
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been immplement")
    }
}
