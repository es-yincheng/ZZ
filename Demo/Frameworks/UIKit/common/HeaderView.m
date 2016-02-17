//
//  HeaderView.m
//  
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property(nonatomic)UILabel *titleLable;

@property(nonatomic)UIImageView *iv;

@end


@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}
-(void)customView
{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.frame.size.width -50, self.frame.size.height)];
    _iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
    [_iv setImage:[UIImage imageNamed:@"fold"]];
    [self addSubview:_iv];
    [self addSubview:_titleLable];
    //添加点击的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer *)tap
{
    if (self.block) {
        self.block();
    }
}

-(void)updateWith:(NSString *)title WithStatus:(BOOL)status
{
    _titleLable.text = title;
    if (status) {
        [_iv setImage:[UIImage imageNamed:@"unfold"]];
    }else{
        [_iv setImage:[UIImage imageNamed:@"fold"]];
    }
}
@end
