//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "HomeCell"

class HomeViewController: UICollectionViewController {

    
// MARK:- 定义属性
    
   lazy var shops : [Shop] = [Shop]()
    
    lazy var photoBrowserTransition : PhotoBrowserTransition = PhotoBrowserTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadHomeData(0)
        
           }

}

// MARK:- 请求数据方法
extension HomeViewController {
    
    func loadHomeData(offset : Int) {
        
        HttpTool.shareInstance.loadHomeData(offset) { (resultArray, error) -> () in
            
//                     print(resultArray)
            
//            print("---\(error)")
            
            //错误校验
            
            if error != nil {
                
                return
            }
            
            //取出传回来的数据
            guard let resultArray = resultArray else {
                
                return
            }
            
            //遍历数组,将取出的模型放到模型数组中
            for dict in resultArray {
                
                let shop = Shop(dict: dict)
                
//                print(shop)
                
                self.shops.append(shop)
                
                print(self.shops)
                
            }
            
            //刷新表格
            
            self.collectionView?.reloadData()
            
            
//            print(self.shops.count)
            
         }
    }
}


//MARK: - 实现数据源和代理方法
extension HomeViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.shops.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //创建cell 
        
    let cell = collectionView .dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)as! HomeViewCell
        
        //设置数据
        cell.backgroundColor = UIColor.purpleColor()
        
         cell.shop = self.shops[indexPath.row]
        
        //当最后一个cell出现时,请求更多数据
        if indexPath.row == self.shops.count - 1 {
            
            loadHomeData(self.shops.count)
            
        }
        
        return cell
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
            //创建图片浏览控制器
            let photoBrowserVC = PhotoBrowserVC()
        
        //传递数据,设置控制器相关属性
        
        photoBrowserVC.shops = shops
        
        photoBrowserVC.indexPath = indexPath
        
        photoBrowserTransition.presentDelegate = self
        
        photoBrowserTransition.indexPath = indexPath
        
        photoBrowserTransition.dismissDelegate = photoBrowserVC
        
        //madal方式
        
//        photoBrowserVC.modalTransitionStyle = .PartialCurl
        
        //设置控制器的弹出方式
        
        photoBrowserVC.modalPresentationStyle = .Custom
        
        //设置转场代理
        
        photoBrowserVC.transitioningDelegate = photoBrowserTransition
        
        //modal
        presentViewController(photoBrowserVC, animated: true, completion: nil)
 
    }
    
}

//MARK: - 实现photoBrowserTransition的presentProtocol方法
extension HomeViewController : PrensentProtocol {
    
    func getImageView(indexPath: NSIndexPath) -> UIImageView {
        
      //创建imageView对象
        
        let imageView = UIImageView()
        
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! HomeViewCell
        
        imageView.image = cell.imageView.image
        
        imageView.contentMode = .ScaleAspectFill
        
        imageView.clipsToBounds = true
        

        return imageView
        
    }
    
    func getStartRect(indexPath: NSIndexPath) -> CGRect {
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? HomeViewCell  else {
            
            return CGRectZero
        }
        
        //将cell的frame转换成所在屏幕的frame
        
        let startRect = collectionView!.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
 
        
        return startRect
  
    }
    
    func getEndRect(indexPath: NSIndexPath) -> CGRect {
       
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! HomeViewCell
        
        let image = cell.imageView.image
        
        
        return calculateImageViewFrame(image!)
    
    }
  
}
