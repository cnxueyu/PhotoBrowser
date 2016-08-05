//
//  PhotoBrowserTransition.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/5.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

//MARK: - 设置协议

protocol PrensentProtocol : class {
    
    func getImageView (indexPath : NSIndexPath) -> UIImageView
    
    func getStartRect (indexPath : NSIndexPath) -> CGRect
    
    func getEndRect (indexPath : NSIndexPath) -> CGRect
    
    
}



class PhotoBrowserTransition: NSObject {

    //MARK: - 定义属性
      var isPresented : Bool = false
    
    var indexPath : NSIndexPath?
    
    weak var presentProtocol : PrensentProtocol?
    
    
    
    
    
}

//MARK: - 实现转场代理方法

extension PhotoBrowserTransition : UIViewControllerTransitioningDelegate {
    //告诉弹出的动画由谁处理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //动画出现
        
        isPresented = true
        
        return self
        
    }
    
    //告诉消失动画由谁处理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //动画消失
        
        isPresented = false
        
        
        return self
        
    }
    
    
}

//MARK: - 实现photoBrowserVC的转场动画代理方法

extension PhotoBrowserTransition : UIViewControllerAnimatedTransitioning {
    
    //动画时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 2.0
        
        
    }
    
    //决定动画如何实现
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresented {
            
            
            guard let indexPath = indexPath, presentProtocol = presentProtocol else {
                
                return
            }
         
            //获取弹出的view
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
         
            //执行动画
              //获取执行动画的imageView
            
            let imageView = presentProtocol.getImageView(indexPath)
            
            //把imageView加到containerView中
            
            transitionContext.containerView()?.addSubview(imageView)
            
            //设置动画的其实位置
            
            imageView.frame = presentProtocol.getStartRect(indexPath)
            
            //从转场上下文中获取上面设置的动画时间
            let duration = transitionDuration(transitionContext)
            
            //将containerView背景色设置为黑色
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                //设置动画的结束位置
                
                imageView.frame = presentProtocol.getEndRect(indexPath)
                
                }) { (_) -> Void in
                    
                    //将弹出的view加到containerView中
                    transitionContext.containerView()?.addSubview(presentView)
                    
                    transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                    
                    imageView .removeFromSuperview()
                    
                    //完成动画
                    
                    transitionContext.completeTransition(true)
                    
            }
            
            
        }else {
            
            //获取消失的view
            
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!

            
            //获取动画的时间
            
            let duration = transitionDuration(transitionContext)
            
            //执行消失动画
            
            UIView .animateWithDuration(duration, animations: { () -> Void in
                
                dismissView.alpha = 0.0
                
                }, completion: { (_) -> Void in
                    
                    dismissView .removeFromSuperview()
                    //完成动画
                    
                    transitionContext.completeTransition(true)
            })
            
        }
        
    }
    
}