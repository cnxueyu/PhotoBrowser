//
//  HomeViewCell.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
   
    var shop : Shop? {
        
        didSet {
            
            //校验nil
            guard let shop = shop else {
                
                return
                
            }
            
            //校验完毕,取出传递过来的url
            guard let url = NSURL(string: shop.q_pic_url) else {
                
                return
            }
            
            guard let name : String? = shop.remark else {
                
                return
            }
            
            //设置文字,图片
            
             nameLabel.text = name
            
     
             imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture"))
            
        }
   
    }

    
}
