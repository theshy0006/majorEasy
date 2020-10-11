//
//  UIImage.swift
//  majorEasy
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit

//// 设置视图渐变色
//func setupUIOne(){
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.frame = self.view.bounds
//    self.view.layer.addSublayer(gradientLayer)
//    
//    gradientLayer.colors = [UIColor.red.cgColor,
//                            UIColor.yellow.cgColor,
//                            UIColor.orange.cgColor]
//    let gradientLocations:[NSNumber] = [0.0,0.8,1.0]
//    gradientLayer.locations = gradientLocations
//    gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
//    gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
//}
//
////设置文字渐变色
//func setupUITwo(){
//    let containerView = UIView.init(frame: CGRect.init(x: 20, y: 100, width: 200, height: 60))
//    self.view.addSubview(containerView)
//    
//    let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 60))
//    label.text = "Darren wang"
//    label.font = UIFont.boldSystemFont(ofSize: 26)
//    containerView.addSubview(label)
//    
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [UIColor.orange.cgColor, UIColor.yellow.cgColor]
//    gradientLayer.locations = [0.0, 1.0]
//    gradientLayer.frame = label.frame
//    containerView.layer.insertSublayer(gradientLayer, at: 0)
//    gradientLayer.mask = label.layer
//}




/*图像拉伸使用示范
 let imageView = UIImageView(frame: CGRect(x:10, y:100, width:300, height:66))
 let image = UIImage(named: "bg")?
                 .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15),
 resizingMode: .stretch) //左右15像素的部分不变，中间部分来拉伸
 imageView.image = image
 view.addSubview(imageView)
 */

/**
 设置背景图片的几种方法
 1，平铺图片
 这种实现起来最简单，只需使用 backgroundColor 属性来设置背景图片即可，效果如下：
 图片始终按照其实际尺寸显示。
 当图片尺寸大于视图时也不会缩小。
 当图片尺寸小于视图时会自动平铺，填满整个视图区域。
 //设置当前视图背景
 self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg1.jpg")!)
 2，拉伸图片
 （1）这种方式是通过改变 layer 层的 contents 来实现的，效果是不管是小图还是大图，都会自动缩放成视图大小，从而完全显示。
 //设置当前视图背景
 self.view.layer.contents = UIImage(named:"bg1.jpg")?.cgImage
 3. 等比例缩放
 另一种是不借助 imageView，而是将原始图片先裁剪成指定尺寸或比例后，再设置为背景。
 //计算视图比例
 let ratio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
 //根据比例裁剪出背景图
 let image = UIImage(named:"bg1.jpg")?.crop(ratio: ratio)
 //设置当前视图背景
 self.view.layer.contents = image?.cgImage
 */

extension UIImage {
    
    //根据颜色来构建图片
    class func imageWithColor(color:UIColor)->UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!
        
    }
    

    
    //用法
    /* 讲一个图片加上一种色彩的图层
     设置各种色调的图片
     imageView1.image = UIImage(named:"logo6")?.tint(UIColor.brownColor(),
     blendMode: .DestinationIn)
     */
    
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        //let context = UIGraphicsGetCurrentContext()
        //CGContextClipToMask(context, drawRect, CGImage)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x:0, y:0, width:reSize.width, height:reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize, height:self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    /*
     //原始图片
     let image = UIImage(named: "image.jpg")!
     //将图片转成 4:3 比例
     let image2 = image.crop(ratio: 4/3)
     //将图片转成 1:1 比例（正方形）
     let image3 = image.crop(ratio: 1)
     */
    
    //将图片缩放成指定尺寸（多余部分自动删除）
    func scaled(to newSize: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = newSize.width/size.width
        let aspectHeight = newSize.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
        
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (newSize.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (newSize.height - size.height * aspectRatio) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    //将图片裁剪成指定比例（多余部分自动删除）
    func crop(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func compressImageOnlength(maxLength: Int) -> Data? {
            let maxL = maxLength * 1024
            var compress:CGFloat = 0.9
            let maxCompress:CGFloat = 0.1
            var imageData = self.jpegData(compressionQuality: compress)
            while (imageData?.count)! > maxL && compress > maxCompress {
                compress -= 0.1
                imageData = self.jpegData(compressionQuality: compress)
            }
            return imageData
        }

    
}

