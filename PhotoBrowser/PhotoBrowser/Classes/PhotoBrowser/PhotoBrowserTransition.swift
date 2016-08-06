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

protocol DismissProtocol : class {
    
    func getImageView () -> UIImageView
    
    func getIndexPath () -> NSIndexPath
    
}


class PhotoBrowserTransition: NSObject {

    //MARK: - 定义属性
      var isPresented : Bool = false
    
    var indexPath : NSIndexPath?
    
    weak var presentDelegate : PrensentProtocol?
    
    weak var dismissDelegate : DismissProtocol?
    
    
    
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
            
            
            guard let indexPath = indexPath, presentDelegate = presentDelegate else {
                
                return
            }
         
            //获取弹出的view
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
         
            //执行动画
              //获取执行动画的imageView
            
            let imageView = presentDelegate.getImageView(indexPath)
            
            //把imageView加到containerView中
            
            transitionContext.containerView()?.addSubview(imageView)
            
            //设置imageView的起始位置
            
            imageView.frame = presentDelegate.getStartRect(indexPath)
            
            //从转场上下文中获取上面设置的动画时间
            let duration = transitionDuration(transitionContext)
            
            //将containerView背景色设置为黑色
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                //设置imageView的结束位置
                
                imageView.frame = presentDelegate.getEndRect(indexPath)
                
                }) { (_) -> Void in
                    
                    //将弹出的view加到containerView中
                    transitionContext.containerView()?.addSubview(presentView)
                    
                    transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                    
                    imageView .removeFromSuperview()
                    
                    //完成动画
                    
                    transitionContext.completeTransition(true)
                    
            }
            
            
        }else {
            
            //校验nil
            
            guard let dismissDelegate = dismissDelegate, presentDelegate = presentDelegate else {
                
                return
            }
            
            
            //获取消失的view
            
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)

//            dismissView?.removeFromSuperview()
            //获取动画的时间
            
            let duration = transitionDuration(transitionContext)
            
            //执行消失动画
               //获取执行动画的imageView
            
            let imageView = dismissDelegate.getImageView()
            
            //将imageView加到containerView中
            
            transitionContext.containerView()?.addSubview(imageView)
            
            //取出indexPath
            
            let indexPath = dismissDelegate.getIndexPath()
            
            //获取结束位置
            
            let endRect = presentDelegate.getStartRect(indexPath)
            
            //设置dismissView的透明度
            
            dismissView?.alpha = endRect == CGRectZero ? 1.0 : 0.0
            
            
            UIView .animateWithDuration(duration, animations: { () -> Void in
        
                if endRect == CGRectZero {
                    
                    imageView.removeFromSuperview()
                    
                    dismissView?.alpha = 0.0
                }else {
                    
                    imageView.frame = endRect
                }
                
                }, completion: { (_) -> Void in
                    
                    dismissView! .removeFromSuperview()
                    //完成动画
                    
                    transitionContext.completeTransition(true)
            })
            
        }
        
    }
    
}