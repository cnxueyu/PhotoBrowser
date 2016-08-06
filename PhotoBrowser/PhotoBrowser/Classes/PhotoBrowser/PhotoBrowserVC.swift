
//
//  PhotoBrowserVC.swift
//  PhotoBrowser
//
//  Created by cnxueyu on 16/8/4.
//  Copyright © 2016年 cnxueyu. All rights reserved.
//

import UIKit

class PhotoBrowserVC: UIViewController {

    //MARK:- 定义属性
    
    var indexPath : NSIndexPath?
    
    var shops : [Shop]?
    
    let PhotoBrowserCellID = "PhotoBrowserCell"
    
    //MARK:- 懒加载
    
    lazy var closeBtn : UIButton = UIButton()
    
    lazy var saveBtn : UIButton = UIButton()
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        view.backgroundColor = UIColor.purpleColor()
     
        //设置图片之间的间距
        
        view.frame.size.width += 15
        
        //设置UI界面
        
        setupUI()
        
        //滚动到对应的位置
        
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: true)
  
        
    }
}


//MARK:- 设置UI界面
extension PhotoBrowserVC {
    
    func setupUI() {
        
        //添加子控件
        
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        //设置子控件的位子
        
        collectionView.frame = view.bounds
        
        let margin : CGFloat = 20
        
        let btnW : CGFloat = 90
        
        let btnH : CGFloat = 32
        
        let x : CGFloat = UIScreen.mainScreen().bounds.width - margin - btnW
        
        let y : CGFloat = UIScreen.mainScreen().bounds.height - margin - btnH
        
        closeBtn.frame = CGRect(x: margin, y: y, width: btnW, height: btnH)
        
        saveBtn.frame = CGRect(x: x, y: y, width: btnW, height: btnH)
        
        //设置button的相关属性--文字,点击事件
        
        prepareBtn()
        
        
        //设置collectionView
        
        prepareCollectionView()
        
        
        
        
    }
    
    func  prepareBtn() {
        
        
        setupBtn(closeBtn, title: "关 闭", action: "closeBtnClick")
        
        setupBtn(saveBtn, title: "保 存", action: "saveBtnClick")
        
       /*
        closeBtn.setTitle("关 闭", forState: .Normal)
        
        closeBtn.backgroundColor = UIColor.darkGrayColor()
        
        closeBtn .addTarget(self, action: Selector("closeBtnClick"), forControlEvents:.TouchUpInside)
        */
        
    }
    
    //抽取方法
    func setupBtn (btn : UIButton , title : String , action : String) {
        
        btn.setTitle(title, forState: .Normal)
        
        btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
        
        btn.backgroundColor = UIColor.darkGrayColor()
        
        btn.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        
    }
    
    
    func prepareCollectionView() {
        
       //设置代理,数据源
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(PhotoBroserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCellID)
        
        
    }
    
//MARK:- 监听按钮点击事件
    @objc private func closeBtnClick() {
        
        print("closeBtnClick")
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @objc private func saveBtnClick() {
        
        print("saveBtnClick")
        
        //取出当前看到cell的图片
        
        let cell = collectionView.visibleCells().first as! PhotoBroserViewCell
        
        guard let image = cell.imageView.image else {
            
            return
        }
        
        //保存图片到系统相册
        
       UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
}

//MARK:- 代理和数据源方法
extension PhotoBrowserVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //取出可选类型的值,如果没有值,取出??后面的值
        return shops?.count ?? 0
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellID, forIndexPath: indexPath) as! PhotoBroserViewCell
        
//        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.blueColor() : UIColor.redColor()
        //传递数据
        cell.shop = shops![indexPath.item]

        return cell;
        
    }
 
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        closeBtnClick()
    }
    
}


//实现DismissProtocol代理方法
extension PhotoBrowserVC : DismissProtocol {
    
    func getImageView() -> UIImageView {
        
        let imageView = UIImageView()
        
        let cell = collectionView.visibleCells().first as! PhotoBroserViewCell
        
        imageView.image = cell.imageView.image
        
        //设置imageView的frame
        
        imageView.frame = cell.imageView.frame
        
        imageView.contentMode = .ScaleAspectFill
        
        imageView.clipsToBounds = true
       
        return imageView
        
    }
    
    func getIndexPath() -> NSIndexPath {
        
        let cell = collectionView.visibleCells().first as! PhotoBroserViewCell
        
        return collectionView.indexPathForCell(cell)!
        
    }
    
}


