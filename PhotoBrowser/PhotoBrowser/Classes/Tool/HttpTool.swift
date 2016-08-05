//
//  HttpTool.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

import AFNetworking

class HttpTool: AFHTTPSessionManager {
    
    static let shareInstance : HttpTool = {
        
        let tool = HttpTool()
        
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")

        return tool

        
    }()
    
   //MARK:- 请求数据
    func loadHomeData (offset : Int, finishedCallBack:(resultArray : [[String : NSObject]]?,error : NSError?) -> ()) {
        
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=\(offset)&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2"
        
        
        //发送请求
        
        GET(urlString, parameters: nil, progress: nil, success: { (_ , result) -> Void in
            
            
//            print(result)
            
            guard let resultDict = result as? [String : NSObject] else {
                
                print("请求的数据有误")
 
                return
                
            }
            
            let dictArray = resultDict["data"] as? [[String : NSObject]]
            
            //将数据回调
            
            finishedCallBack(resultArray: dictArray, error: nil)
 
            
            }) { (_ , error ) -> Void in
                
                print(error)
                
                finishedCallBack(resultArray: nil, error: error)
                
        }
  
        
    }
  
}
