//
//  NBSelectView.m
//
//  Created by dede wang on 2019/10/25.
//

#import "NBSelectView.h"
@interface NBSelectView()
@end

@implementation NBSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createUI];
        [self createSubUI];
    }
     return self;
}

- (void)createSubUI{
    CGFloat width;

    width = SCREEN_WIDTH / 3;
    self.sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sortBtn.frame = CGRectMake(width * 2, 0, width, 40);
    [self setUpButton:self.sortBtn withText:@"排序"];
    
    self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondBtn.frame = CGRectMake(width, 0, width, 40);


    /** 最下面横线 */
    UILabel *lineLb = [[UILabel alloc] init];
    lineLb.frame = CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH, 1);
    lineLb.backgroundColor = RGBHex(0xe0e0e0);
    [self addSubview:lineLb];
}

- (void)createUI{
    CGFloat width;
    width = SCREEN_WIDTH / 3;
    self.firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.firstBtn.frame = CGRectMake(0, 0, width, 40);
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
    } else {
        if (self.itemBtnBlock) {
            self.itemBtnBlock(3);
        }
        [UIView animateWithDuration:0.2 animations:^{
        self.sortBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);}];
    }
}

@end
