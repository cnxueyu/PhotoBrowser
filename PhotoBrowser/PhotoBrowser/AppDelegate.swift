//
//  AppDelegate.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/5.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }


}
//MARK:- 根据下载的图片尺寸计算imageView的尺寸
func calculateImageViewFrame(image : UIImage) -> CGRect {
        
        let imageViewW = UIScreen.mainScreen().bounds.width
        
        let imageViewH = imageViewW * image.size.height / image.size.width
        
        let x : CGFloat = 0
        
        let y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
        
        return CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
        
    }



