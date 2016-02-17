//
//  UIView+YCBlur.m
//  ZZ
//
//  Created by cheng yin on 15/12/25.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "UIView+YCBlur.h"
#import "UIImage+GIF.h"

@implementation UIView (YCBlur)

-(void)blurWithImageName:(NSString *)image alpha:(float)alpha
{
    self.frame = CGRectMake(0, NAVH, SCRENW, SCRENH-NAVH);
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.frame];
    UIBlurEffect *blureff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blureff];
    visualEffect.frame = self.bounds;
    visualEffect.alpha = alpha;
    NSString *imagePath;
    if (image) {
        imagePath = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    } else {
        imagePath = [[NSBundle mainBundle] pathForResource:@"left_back_3" ofType:@"png"];
    }
    backImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [backImageView addSubview:visualEffect];
    [self addSubview:backImageView];
}

-(void)blurWithGif:(NSString *)gif alpha:(float)alpha
{
    self.frame = CGRectMake(0, NAVH, SCRENW, SCRENH-NAVH);
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.frame];
    UIBlurEffect *blureff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:blureff];
    visualEffect.frame = self.bounds;
    visualEffect.alpha = alpha;

    backImageView.image = [UIImage sd_animatedGIFNamed:gif];
    [backImageView addSubview:visualEffect];
    [self addSubview:backImageView];
}

@end
