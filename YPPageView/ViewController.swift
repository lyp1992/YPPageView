//
//  ViewController.swift
//  YPPageView
//
//  Created by 赖永鹏 on 2018/11/22.
//  Copyright © 2018年 LYP. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView();
        tableView.frame = self.view.bounds;
        tableView.delegate = self;
        tableView.dataSource = self;
        return tableView;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
   
//        setupUI()
        
        let style = YPPageStyle()
        style.isScrollEnable = true
        
        
        let titles = ["推荐", "游戏游戏游戏", "热门游戏", "趣玩游", "娱乐", "热门游戏2", "趣玩游2", "娱乐2"]
        
        var childVCs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/256.0, green: CGFloat(arc4random_uniform(256))/256.0, blue: CGFloat(arc4random_uniform(256))/256.0, alpha: 1.0)
            childVCs.append(vc)
        }
        
//        创建pageView
        let pageVFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        let pageView = YPPageView(frame: pageVFrame, style: style, titles: titles, childVCs: childVCs)
        
        view.addSubview(pageView);
        
    }

}

extension ViewController {
    fileprivate func setupUI() {
        view.addSubview(tableView);
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = "测试数据:\(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

