//
//  ViewController.swift
//  MJTest
//
//  Created by idea on 2018/8/6.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import  ChainableAnimations
class ViewController: UIViewController {

    var s = true
//    侧边栏
    lazy var sideView: SideView = {
        let sideView = SideView()
        return sideView.pin(.xywh(-300,0,300,kScreenH)).bg(kRandom+",0.6")
    }()
    //    Stack
    lazy var scrollView: StackScrollView = {
        let scrollView = StackScrollView()
        scrollView.delegate = self
        
        return scrollView
    }()
    lazy var btn: UIButton = {
        return Button.str("❂").color(kAppColor).font(38).pin(.maxX(-20),.y(20)).onClick({[weak self] _ in
            self!.setupAnimator()
        })
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
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.addSubviews(sideView,scrollView,btn)
        scrollView.makeCons { (make) in
            make.edge.equal(view)
        }
        scrollView.reloadData(lives: models)
        
        sideView.reloadData("http://placeimg.com/160/160/tech","丹歌起势",KPLACEHOLDER,"⚙︎")
        sideView.setbtn.onClick { [weak self] b in
            self!.setupSidebtn(b)
        }
    }
    func setupSidebtn(_ setb:UIButton){
        let b = ChainableAnimator(view: setb)
        b.move(x: -50).rotate(angle: 360).animate(t: 0.5)
        b.completion = {
            ActionSheet.message("设置").tint(kAppColor).action("更改背景", {[weak self] in
                self?.sideView.bg(kRandom+",0.7")
                self?.setb(b)
            }).action("随便点点", {[weak self] in
                self?.setb(b)
            }).show()
            
        }
    }
    func setb(_ b:ChainableAnimator){
        b.move(x: 50).rotate(angle: -360).animate(t: 1.0)
    }

    func setupAnimator(){
        let animator = ChainableAnimator(view: btn)
        let an = ChainableAnimator(view: scrollView)
        let side = ChainableAnimator(view: sideView)
        switch s {
        case true:
            animator.rotate(angle: -90).animate(t: 0.2);
            animator.completion = {
                animator.rotate(angle: -180).animate(t: 0.5);
                an.easeIn.move(x: 300).animate(t: 0.5);
                side.move(x: 300).animate(t: 0.5)
            }
        default:
            animator.rotate(angle: 90).animate(t: 0.2);
            animator.completion = {
                animator.rotate(angle: 180).animate(t: 0.5);
                an.easeIn.move(x: -300).animate(t: 0.5);
                side.move(x: -300).animate(t: 0.5)
            }
        }
        s = !s
    }

}
// MARK: - delegate
extension ViewController: StackScrollViewDelegate {
    func stackScrollViewBtnDidClick(view: StackScrollView, model: StackModel, index:Int) {
        print("点击了\(model.title!)");
        if !s {
            setupAnimator()
        }else{
            let viewController = DetailViewController()
            viewController.cc_setZoomTransition(originalView: view.liveBtns[index])
            viewController.img.sd_setImage(with: URL(string: model.imageUrl!), placeholderImage: UIImage(named: "noNet"))
            self.present(viewController, animated: true, completion: nil)
        }
        

    }
}
