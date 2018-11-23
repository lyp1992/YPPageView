//
//  YPContentView.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2018/11/22.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

private let collectionID = "YPcellID"

class YPContentView: UIView {

    var childVCs : [UIViewController]
    var parentVC : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = self.bounds.size
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionID)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()

    init(frame : CGRect,childVCs : [UIViewController], parentVC : UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been immplement")
    }
    
}

extension YPContentView {
    fileprivate func setupUI(){
        addSubview(collectionView)
        
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
    }
}

extension YPContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVC  = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
        
    }
}

extension YPContentView : UICollectionViewDelegate {
    
}
