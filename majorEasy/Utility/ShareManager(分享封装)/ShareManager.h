//
//  ShareManager.h
//  ChaZX
//
//  Created by dede wang on 2019/10/31.
//  Copyright © 2019 周家康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ShareType) {
    TencentQQ,
    QZONE,
    WECHAT,
    WECHATZONE,
};

typedef NS_ENUM(NSInteger, ShareStyle) {
    company,
    cargo,
};

@interface ShareManager : NSObject<WXApiManagerDelegate>

+(ShareManager *) shareInstance;

- (void) shareWeChatFriend:(NSString*)name
                andContent:(NSString*)content
                     image:(NSString*)image
                  linkWith:(NSString*)link
                 shareType:(ShareType)type
                 style:(ShareStyle) style;
@end

NS_ASSUME_NONNULL_END
