//
//  NBSelectSmallView.h
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBSelectSmallView : UIView

@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;

- (instancetype)initWithFrame:(CGRect)frame;
-(void)setUpButton:(UIButton *)button withText:(NSString *)str;

@property (nonatomic, strong) void (^itemBtnBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
