//
//  UserCenterHeader.m
//  ZZ
//
//  Created by cheng yin on 15/12/31.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "UserCenterHeader.h"
#import "UMSocial.h"

typedef NS_OPTIONS(NSUInteger, LoginBy) {
    LoginByDefault = 0,
    LoginByWeibo,
    LoginByQQ,
    LoginByWeixin
};

@implementation UserCenterHeader

-(instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
        [self setFrame];
    }
    return self;
}


#pragma mark - 自定义方法
/**
 *  添加控件到视图上
 */
-(void)addView
{
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.userInfo];
    
    //登录按钮
    [self addSubview:self.qqIcon];
    [self addSubview:self.weiboIcon];
    [self addSubview:self.weixinIcon];
}

/**
 *  设置控件frame
 */
-(void)setFrame
{
#define UserIconWith 40
#define UserIconHeig UserIconWith
#define SPACE 5
    self.userIcon.frame = CGRectMake((BOUNDSWITH-UserIconWith)/2, 20, UserIconWith, UserIconHeig);
    
    self.userName.frame = CGRectMake(0, CGRectGetMaxY(self.userIcon.frame)+SPACE, BOUNDSWITH, 20);
    
    self.userInfo.frame = CGRectMake(0, CGRectGetMaxY(self.userName.frame)+SPACE, BOUNDSWITH, 20);
    
#define BUTTONWITH 30
    self.weixinIcon.frame = CGRectMake((BOUNDSWITH/3-BUTTONWITH)/2, CGRectGetMaxY(self.userInfo.frame)+SPACE, BUTTONWITH, BUTTONWITH);
    
    self.qqIcon.frame = CGRectMake((BOUNDSWITH-BUTTONWITH)/2, CGRectGetMaxY(self.userInfo.frame)+SPACE, BUTTONWITH, BUTTONWITH);
    
    self.weiboIcon.frame = CGRectMake((5*BOUNDSWITH/3-BUTTONWITH)/2, CGRectGetMaxY(self.userInfo.frame)+SPACE, BUTTONWITH, BUTTONWITH);
}


-(void)login:(UIButton*)sender
{
    NSString *shareType;
    switch (sender.tag) {
        case LoginByDefault: {
            YCLog(@"点击头像将跳转默认登录注册界面");
            break;
        }
        case LoginByWeibo: {
            shareType = UMShareToSina;
            break;
        }
        case LoginByQQ: {
            shareType = UMShareToQQ;
            break;
        }
        case LoginByWeixin: {
            shareType = UMShareToWechatSession;
            break;
        }
    }
    
    //第三方登录
    if (shareType.length>0) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:shareType];
        snsPlatform.loginClickHandler(self.window.rootViewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:shareType];
                
                //            NSLog(@"微信登录： username is %@, openId is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.openId,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                //            NSLog(@"%@",snsAccount);
                
                [self updateViewWithUMSocialAccountEntity:snsAccount];
            }
        });
    }
}

/**
 *  根据登录授权结果更新界面
 *
 *  @param snsAccount 授权结果
 */
-(void)updateViewWithUMSocialAccountEntity:(UMSocialAccountEntity*)snsAccount
{
    [self.userIcon sd_setImageWithURL:[[NSURL alloc] initWithString:snsAccount.iconURL] forState:UIControlStateNormal];
    self.userName.text = snsAccount.userName;
    self.userInfo.text = snsAccount.profileURL.length>0?snsAccount.profileURL:@"快来说点什么吧";
    self.weiboIcon.hidden = YES;
    self.qqIcon.hidden = YES;
    self.weixinIcon.hidden = YES;
}

#pragma mark - getter

-(UIButton*)userIcon
{
    if (!_userIcon) {
        _userIcon = [[UIButton alloc] init];
        [_userIcon setImage:[UIImage imageNamed:@"my"] forState:UIControlStateNormal];
        _userIcon.tag = LoginByDefault;
        [_userIcon addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userIcon;
}

-(UILabel*)userName
{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = FONTNAME;
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.textColor = [UIColor whiteColor];
        _userName.text = @"未登录";
    }
    return _userName;
}

-(UILabel*)userInfo
{
    if (!_userInfo) {
        _userInfo = [[UILabel alloc] init];
        _userInfo.font = FONTINFO;
        _userInfo.textAlignment = NSTextAlignmentCenter;
        _userInfo.textColor = [UIColor whiteColor];
        _userInfo.text = @"点击头像或选择以下方式登录吧！";
    }
    return _userInfo;
}

-(UIButton*)weiboIcon
{
    if (!_weiboIcon) {
        _weiboIcon = [[UIButton alloc] init];
        _weiboIcon.tag = LoginByWeibo;
        [_weiboIcon addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [_weiboIcon setImage:[UIImage imageNamed:@"aperture_32x32"] forState:UIControlStateNormal];
    }
    return _weiboIcon;
}

-(UIButton*)qqIcon
{
    if (!_qqIcon) {
        _qqIcon = [[UIButton alloc] init];
        _qqIcon.tag = LoginByQQ;
        [_qqIcon addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [_qqIcon setImage:[UIImage imageNamed:@"aperture_32x32"] forState:UIControlStateNormal];
    }
    return _qqIcon;
}

-(UIButton*)weixinIcon
{
    if (!_weixinIcon) {
        _weixinIcon = [[UIButton alloc] init];
        _weixinIcon.tag = LoginByWeixin;
        [_weixinIcon addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [_weixinIcon setImage:[UIImage imageNamed:@"aperture_32x32"] forState:UIControlStateNormal];
    }
    return _weixinIcon;
}

@end
