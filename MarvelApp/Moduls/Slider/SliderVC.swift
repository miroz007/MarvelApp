//
//  SliderVC.swift
//  MarvelApp
//
//  Created by Amir on 1/27/21.
//  Copyright © 2021 Amir. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class SliderVC: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {
    
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            pagerView.automaticSlidingInterval = 0.0
            pagerView.isInfinite = true
            pagerView.itemSize = CGSize(width: 320, height: 280)
            pagerView.interitemSpacing = 10
            pagerView.transformer = FSPagerViewTransformer(type: .overlap)
            let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
            self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
            self.pagerView.decelerationDistance = FSPagerView.automaticDistance
        }
    }
    
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.hidesForSinglePage = true
            
            DispatchQueue.main.async {
                self.pageControl.numberOfPages = self.items.count
                self.pagerView.reloadData()
            }
        }
    }
    
    var items = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.delegate = self
        pagerView.dataSource = self
        
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return items.count
        
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        cell.imageView?.image = UIImage(named: "placeholder")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        if let image = items[index].thumbnail?.path , let ext = items[index].thumbnail?._extension {
            if  let url = URL(string: image+"."+ext) {
                cell.imageView?.kf.setImage(with: url)
            }
        }

        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    
    
    
}
