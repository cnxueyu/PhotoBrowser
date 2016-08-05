//
//  PhotoBrowserLayout.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

class PhotoBrowserLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        
        //设置layout的相关属性
        
        itemSize = (collectionView?.bounds.size)!
        
        minimumLineSpacing = 0
        
        minimumInteritemSpacing = 0
        
        scrollDirection = .Horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView?.pagingEnabled = true
        
//        collectionView?.backgroundColor = UIColor.blueColor()
        
        
    }
    
    
}
