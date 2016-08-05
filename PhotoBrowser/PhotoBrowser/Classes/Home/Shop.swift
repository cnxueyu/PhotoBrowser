//
//  Shop.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

class Shop: NSObject {
    ///小图
    var q_pic_url : String = ""
    
    ///大图
    var z_pic_url : String = ""
    
    ///商品名
    var remark : String = ""
    
    ///价格
    var title : String = ""
    
    init(dict : [String : NSObject]) {
        
        super.init()
        
        
        //字典数组转模型
        
        setValuesForKeysWithDictionary(dict)
        
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
}
