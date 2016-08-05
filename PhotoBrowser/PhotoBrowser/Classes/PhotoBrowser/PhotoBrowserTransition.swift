//
//  PhotoBrowserTransition.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/5.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

class PhotoBrowserTransition: NSObject {

      var isPresented : Bool = false
    
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
            //获取弹出的view
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            //将弹出的view教导containerView中
            
            transitionContext.containerView()?.addSubview(toView)
            
            //执行动画
            //从转场上下文中获取上面设置的动画时间
            let duration = transitionDuration(transitionContext)
            
            toView.alpha = 0.0
            
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                toView.alpha = 1.0
                
                }) { (_) -> Void in
                    
                    //完成动画
                    
                    transitionContext.completeTransition(true)
            }
            
            
        }else {
            
            //获取消失的view
            
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            //将消失的view加到containerView中
            
            transitionContext.containerView()?.addSubview(dismissView)
            
            //获取动画的时间
            
            let duration = transitionDuration(transitionContext)
            
            //执行消失动画
            
            UIView .animateWithDuration(duration, animations: { () -> Void in
                
                dismissView.alpha = 0.0
                
                }, completion: { (_) -> Void in
                    
                    //完成动画
                    
                    transitionContext.completeTransition(true)
            })
            
        }
        
    }
    
}