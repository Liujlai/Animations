//
//  StackScrollView.swift
//  swift_D
//
//  Created by idea on 2018/7/28.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
@objc protocol StackScrollViewDelegate {
    func stackScrollViewBtnDidClick(view:StackScrollView, model: StackModel, index:Int)
}

class StackScrollView: UIView {
    var delegate: StackScrollViewDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        scrollView.makeCons{(make) in
            make.edge.equal(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var lives: [StackModel] = [StackModel]()
    var liveBtns: [StackView] = [StackView]()
    
    
    let closeHeight: CGFloat = 200
    let closeSpac: CGFloat = 100
    let labelSpac: CGFloat = 35
    
    
    var lastOffset: CGFloat = 0
}

// MARK: - public method
extension StackScrollView {
    func reloadData(lives: [StackModel]) {
        self.lives = lives
        
        for btn in liveBtns {
            btn.isHidden = true
            btn.remakeCons { (make) in
                
            }
        }
        
        for i in 0..<lives.count {
            let model = lives[i]
            var btn: StackView
            if i < liveBtns.count {
                btn = self.liveBtns[i]
                btn.isHidden = false
            } else {
                btn = StackView()
                btn.imageView?.contentMode = .scaleAspectFill
                btn.adjustsImageWhenHighlighted = false
                btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
                scrollView.addSubview(btn)
                liveBtns.append(btn)
            }
            
            btn.tag = i
            btn.model = model
            
            if i == 0 {
                btn.memoLabel.alpha = 1.0
                btn.memoLabel.remakeCons { (make) in
                    make.centerX.equal(btn)
                    make.bottom.equal(btn).offset(-50-200)
                }
                btn.nameLabel.remakeCons { (make) in
                    make.centerX.equal(btn)
                    make.centerY.equal(btn).bottom.offset(-50-closeSpac-closeSpac-labelSpac)
                }
            }
            
            btn.remakeCons({ (make) in
                make.left.right.equal(scrollView)
                make.width.equal(scrollView)
                if i == 0 {
                    make.height.equal(scrollView)
                    make.top.equal(scrollView)
                    let offset = (kScreenH)*CGFloat(self.lives.count-1)
                    make.bottom.equal(scrollView).offset(-offset)
                } else {
                    make.height.equal(closeHeight)
                    let offset = kScreenH-closeHeight+closeSpac*CGFloat(i-1)
                    make.top.equal(scrollView).offset(offset)
                }
            })
        }
        
    }
}

// MARK: - life cycle
extension StackScrollView {
    
}

// MARK: - delegate
extension StackScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if self.liveBtns.count == 0 || offsetY < 0 || offsetY >= scrollView.frame.size.height*CGFloat(self.liveBtns.count-1) {
            return
        }
        
        var currentIndex = Int(offsetY/scrollView.frame.size.height-0.00001)
        
        if offsetY > lastOffset {
            let offset = scrollView.contentOffset.y - CGFloat(currentIndex)*scrollView.frame.size.height
            let progress = offset/scrollView.frame.size.height
            let btn = self.liveBtns[currentIndex+1]
            let top = scrollView.frame.size.height*CGFloat(currentIndex+1)-closeHeight+closeHeight*progress
            let height = closeHeight + (scrollView.frame.size.height - closeHeight)*progress
            btn.memoLabel.alpha = progress
            btn.makeCons({ (make) in
                make.height.equal(height)
                make.top.equal(scrollView).offset(top)
            })
            btn.memoLabel.remakeCons { (make) in
                make.centerX.equal(btn)
                make.bottom.equal(btn).offset(-50-closeSpac-closeSpac*progress)
            }
            liveBtns[currentIndex].memoLabel.remakeCons({ (make) in
                make.centerX.equal(liveBtns[currentIndex])
                make.bottom.equal(liveBtns[currentIndex]).offset(-50-closeHeight*(1-progress))
            })
            btn.nameLabel.remakeCons { (make) in
                make.centerX.equal(btn)
                make.centerY.equal(btn).bottom.offset(-50-closeSpac-(closeSpac+labelSpac)*progress)
            }
            liveBtns[currentIndex].nameLabel.remakeCons({ (make) in
                make.centerX.equal(liveBtns[currentIndex])
                make.centerY.equal(liveBtns[currentIndex]).bottom.offset(-50-labelSpac-closeHeight*(1-progress))
            })
            
            if currentIndex >= 1 {
                for index in 1...currentIndex {
                    let openBtn = self.liveBtns[index]
                    openBtn.makeCons({ (make) in
                        make.height.equal(scrollView.frame.size.height)
                        make.top.equal(scrollView).offset(CGFloat(index)*scrollView.frame.size.height)
                    })
                }
            }
            
            for index in currentIndex+2..<self.liveBtns.count {
                let closeBtn = self.liveBtns[index]
                closeBtn.makeCons({ (make) in
                    let offset = scrollView.frame.size.height*CGFloat(currentIndex+1)-closeHeight+closeSpac*CGFloat(index-currentIndex-1)+(scrollView.frame.size.height-closeSpac)*progress
                    make.top.equal(scrollView).offset(offset)
                })
            }
        } else {
            currentIndex += 1
            let offset = scrollView.contentOffset.y - CGFloat(currentIndex)*scrollView.frame.size.height
            let progress = offset/scrollView.frame.size.height
            let btn = self.liveBtns[currentIndex]
            let top = scrollView.frame.size.height*CGFloat(currentIndex)-closeHeight+closeHeight*(1+progress)
            let height = closeHeight + (scrollView.frame.size.height - closeHeight)*(1+progress)
            btn.memoLabel.alpha = 1+progress
            btn.makeCons({ (make) in
                make.height.equal(height)
                make.top.equal(scrollView).offset(top)
            })
            btn.memoLabel.remakeCons { (make) in
                make.centerX.equal(self)
                make.bottom.equal(self).offset(-50-closeSpac-closeSpac*(1+progress))
            }
            liveBtns[currentIndex-1].memoLabel.remakeCons({ (make) in
                make.centerX.equal(liveBtns[currentIndex-1])
                make.bottom.equal(liveBtns[currentIndex-1]).offset(-50+closeHeight*progress)
            })
            btn.nameLabel.remakeCons { (make) in
                make.centerX.equal(btn)
                make.centerY.equal(btn).bottom.offset(-50-closeSpac-(closeSpac+labelSpac)*(1+progress))
            }
            liveBtns[currentIndex-1].nameLabel.remakeCons({ (make) in
                make.centerX.equal(liveBtns[currentIndex-1])
                make.centerY.equal(liveBtns[currentIndex-1]).bottom.offset(-50-labelSpac+closeHeight*progress)
            })
            
            for index in currentIndex+1..<self.liveBtns.count {
                let closeBtn = self.liveBtns[index]
                closeBtn.makeCons({ (make) in
                    var offset = scrollView.frame.size.height*CGFloat(currentIndex)-closeHeight+closeSpac*CGFloat(index-currentIndex-1)
                    offset += scrollView.frame.size.height*CGFloat(1+progress) - closeSpac*progress
                    make.top.equal(scrollView).offset(offset)
                })
            }
        }
        
        lastOffset = offsetY
    }
}

// MARK: - event response
extension StackScrollView {
    @objc func btnClick(btn: StackView) {
        if btn.frame.size.height > 210 {
            print( btn.tag)
            self.delegate?.stackScrollViewBtnDidClick(view: self, model: btn.model, index:btn.tag )
            return
        }
        
        let index = btn.tag
        let offsetY = self.scrollView.frame.size.height * CGFloat(index)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
}

// MARK: - private method
extension StackScrollView {
    
}
