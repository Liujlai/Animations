//
//  ViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var scrollView: StackScrollView = {
        let scrollView = StackScrollView()
        scrollView.delegate = self
        
        return scrollView
    }()
    var models: [StackModel] = {
        let models = [
            StackModel(title: "天地匆匆", desc: "惊鸿而过", imageUrl: "http://img5.adesk.com/57d7d601fce12b0f8f1c997e?imageMogr2/thumbnail/!1440x2392r/gravity/Center/crop/1440x2392&adult=false.png"),
            StackModel(title: "遑遑无归", desc: "闲云逸鹤", imageUrl: "http://img5.adesk.com/5800b3eefce12b4b3309f90c?imageMogr2/thumbnail/!1440x2392r/gravity/Center/crop/1440x2392&adult=false.png"),
            StackModel(title: "引势而流", desc: "鸿门乱局", imageUrl: "http://img5.adesk.com/59c5d143e7bce77b1b837f62?imageMogr2/thumbnail/!1440x2392r/gravity/Center/crop/1440x2392&adult=false.png"),
            StackModel(title: "丹歌起势", desc: "同风而起", imageUrl: "http://img5.adesk.com/573e92e6fce12b3b4f2163a9?imageMogr2/thumbnail/!1440x2392r/gravity/Center/crop/1440x2392&adult=false.png"),
            StackModel(title: "卧龙低伏", desc: "入我阵来", imageUrl: "http://img5.adesk.com/5a61a281e7bce736a953c2ca?imageMogr2/thumbnail/!1440x2392r/gravity/Center/crop/1440x2392&adult=false.png")
        ];
        return models;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.makeCons { (make) in
            make.edge.equal(view)
        }
        
        scrollView.reloadData(lives: models)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - delegate
extension ViewController: StackScrollViewDelegate {
    func stackScrollViewBtnDidClick(view: StackScrollView, model: StackModel, index:Int) {
        print("点击了\(model.title!)");
//        Defaults[.username] = "joe"
//        MBProgressHUD.showInfo(Defaults[.username]!)
//        navigate(.login)//跳转到test
        let viewController = DetailViewController()
        viewController.cc_setZoomTransition(originalView: view.liveBtns[index])
        viewController.img.sd_setImage(with: URL(string: model.imageUrl!), placeholderImage: UIImage(named: "noNet"))
        self.present(viewController, animated: true, completion: nil)

    }
}
