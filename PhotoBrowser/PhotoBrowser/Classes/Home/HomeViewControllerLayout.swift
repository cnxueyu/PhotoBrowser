//
//  HomeViewControllerLayout.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

class HomeViewControllerLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        //设置常量
        
        let margin : CGFloat = 10
        
        let itemWH : CGFloat = ( UIScreen.mainScreen().bounds.width - 4 * margin ) / 3 - 0.001
        
         
        //布局
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        
        minimumLineSpacing = margin
        
        minimumInteritemSpacing = margin
        
        //设置collectionView的内边距
        
        collectionView?.contentInset = UIEdgeInsets(top: margin + 64, left: margin, bottom: margin, right: margin)
        
        
        
        
    }
    
    

    
}
