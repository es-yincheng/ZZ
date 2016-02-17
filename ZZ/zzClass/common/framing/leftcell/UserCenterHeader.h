//
//  UserCenterHeader.h
//  ZZ
//
//  Created by cheng yin on 15/12/31.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterHeader : UIView

/**
 *  用户头像
 */
@property (nonatomic, strong) UIButton *userIcon;

/**
 *  用户名称
 */
@property (nonatomic, strong) UILabel *userName;

/**
 *  用户介绍
 */
@property (nonatomic, strong) UILabel *userInfo;

/**
 *  微博登录按钮
 */
@property (nonatomic, strong) UIButton *weiboIcon;

/**
 *  QQ登录按钮
 */
@property (nonatomic, strong) UIButton *qqIcon;

/**
 *  微信登录按钮
 */
@property (nonatomic, strong) UIButton *weixinIcon;

-(instancetype)initWithFrame:(CGRect)frame;

@end
