//
//  ShareView.h
//  ZZ
//
//  Created by cheng yin on 15/12/24.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property (nonatomic, strong) UIWindow *wind;
@property (nonatomic, strong) UIImageView *shareIcon;
@property (nonatomic, strong) UIImageView *shareImage;
- (instancetype)initWithFrame:(CGRect)frame AboveWindow:(UIWindow*)wind;
@end
