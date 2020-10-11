//
//  ShareManager.m
//  ChaZX
//
//  Created by dede wang on 2019/10/31.
//  Copyright © 2019 周家康. All rights reserved.
//

#import "ShareManager.h"
// MARK:-- 图片使用的封装
#define ImageNamed(imageName) [UIImage imageNamed: imageName]
@implementation ShareManager

+(ShareManager *) shareInstance {
    static ShareManager* manager = nil;
       static dispatch_once_t predicate;
       dispatch_once(&predicate, ^{
           manager = [[[self class] alloc] init];
       });
       WXApiManager.sharedManager.delegate = manager;
       return manager;
}

#pragma mark - 压缩图片
- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}



- (void) shareWeChatFriend:(NSString*)name
                andContent:(NSString*)content
                     image:(NSString*)image
                  linkWith:(NSString*)link
                 shareType:(ShareType)type
                 style:(ShareStyle) style; {
        
    UIImage * pressImage = [self compressImage:ImageNamed(@"bigCar") toByte:32*1024];
    SendMessageToWXReq *req1 = [[SendMessageToWXReq alloc]init];
    req1.bText =  NO;
    //    WXSceneSession  = 0,        /**< 聊天界面    */
    //    WXSceneTimeline = 1,        /**< 朋友圈      */
    //    WXSceneFavorite = 2,
    if (type == WECHAT) {
        req1.scene = WXSceneSession;
    } else {
        req1.scene = WXSceneTimeline;
    }

    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    NSString *title;
    NSString * description;
    if (style == company) {
        if (content.length != 0) {
            title = [NSString stringWithFormat:@"【%@】主营：%@",name, content];
        } else {
            title = [NSString stringWithFormat:@"【%@】",name];
        }
        description = @"查物流-专线查询、快递查询、找货找车";
    } else {
        title = name;
        description = content;
    }
    

    urlMessage.title = title;//分享标题
    urlMessage.description = description;//分享描述
    [urlMessage setThumbImage:pressImage];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = link;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    req1.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:req1];
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response{
    if (response.errCode == 0){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
    }
}


@end
