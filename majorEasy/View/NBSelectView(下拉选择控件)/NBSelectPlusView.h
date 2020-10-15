//
//  NBSelectPlusView.h
//  majorEasy
//
//  Created by wangyang on 2020/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBSelectPlusView : UIView

@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIButton *threeBtn;
@property (nonatomic, strong) UIButton *fourBtn;

- (instancetype)initWithFrame:(CGRect)frame;
-(void)setUpButton:(UIButton *)button withText:(NSString *)str;

@property (nonatomic, strong) void (^itemBtnBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

