//
//  NBSelectSmallView.m
//  majorEasy
//
//  Created by wangyang on 2020/11/19.
//

#import "NBSelectView.h"
#import "NBSelectSmallView.h"

@implementation NBSelectSmallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createUI];
    }
     return self;
}

- (void)createUI{
    CGFloat width;
    width = SCREEN_WIDTH / 2;
    self.firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstBtn.frame = CGRectMake(0, 0, width, 40);
    
    self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondBtn.frame = CGRectMake(width, 0, width, 40);
    
    [self setUpButton:self.firstBtn withText:@"工作地区"];
    [self setUpButton:self.secondBtn withText:@"司机职位"];
    /** 最下面横线 */
    UILabel *lineLb = [[UILabel alloc] init];
    lineLb.frame = CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH, 1);
    lineLb.backgroundColor = RGBHex(0xe0e0e0);
    [self addSubview:lineLb];
}

#pragma mark -- 设置Button
-(void)setUpButton:(UIButton *)button withText:(NSString *)str{
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button setTitle:str forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleColor:RGBHex(0x333333) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_unselect_arrow"] forState:UIControlStateNormal];
    [self buttonEdgeInsets:button];
}

-(void)buttonEdgeInsets:(UIButton *)button{
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.bounds.size.width + 2, 0, button.imageView.bounds.size.width + 10)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + 10, 0, -button.titleLabel.bounds.size.width + 2)];
}

#pragma mark -- 按钮点击推出菜单 (并且其他的菜单收起)
-(void)btnClick:(UIButton *)btn {
    if (btn == self.firstBtn) {
        if (self.itemBtnBlock) {
            self.itemBtnBlock(1);
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.firstBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);}];
    } else if (btn == self.secondBtn) {
        if (self.itemBtnBlock) {
            self.itemBtnBlock(2);
        }
        [UIView animateWithDuration:0.2 animations:^{
        self.secondBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);}];
    }
}

@end

