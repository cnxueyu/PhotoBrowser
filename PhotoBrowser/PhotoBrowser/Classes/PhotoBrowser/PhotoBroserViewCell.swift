//
//  PhotoBroserViewCell.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBroserViewCell: UICollectionViewCell {
    
    //MARK:- 懒加载
    
    lazy var imageView : UIImageView = UIImageView()
    
    //MARK: -构造函数
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        
        contentView .addSubview(imageView)
    }
    
    //如果实现父类的构造函数,那么必须实现用required修饰的这个构造函数
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        contentView .addSubview(imageView)
    }
    
    
    var shop : Shop? {
        
        didSet {
            //校验nil
            guard let shop = shop else {
                
                return
                
            }
            //先从内存中取小图作为占位图片
            var image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(shop.q_pic_url)
            
            if image == nil {
                //如果没有,用现有的占位图片
                image = UIImage(named: "empty_picture")
                
            }
            //根据实际图片计算imageView的frame
          imageView.frame = calculateImageViewFrame(image)
            
            //校验大图的url是否存在
            guard let url = NSURL(string: shop.z_pic_url) else {
                
                imageView.image = image
                
                return
                
            }
            
            //下载图片
            imageView .sd_setImageWithURL(url, placeholderImage: image) { (image, _, _, _) -> Void in
            
            //下载大图后再次根据大图计算imageView的frame
            self.imageView.frame = calculateImageViewFrame(image)
                
            }
            
        }
        
        
    }

    
}

