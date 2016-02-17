//
//  MyViewController.m
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "MyViewController.h"
#import "UMSocial.h"
//#import "UMSocialScreenShoter.h"
//#import "UMSocialShakeService.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setCustomView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[self getControllerName]];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self getControllerName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCustomView
{
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"my";
    
    UIButton *go = [[UIButton alloc] initWithFrame:CGRectMake(40, 80, 60, 30)];
    [go setTitle:@"go" forState:UIControlStateNormal];
    [go addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:go];
    
//    [self shareScreenShot];
}

- (IBAction)go:(UIButton*)sender
{
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeDefault url:@"www.baidu.com"];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:YOUMENGAPK
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"left_back_0"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToFacebook,UMShareToTwitter,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,nil]
                                       delegate:nil];
}

/**
 *  回调方法
 *
 *  @param response <#response description#>
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


//-(void)shareScreenShot
//{
//    //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
//    [UMSocialShakeService setShakeThreshold:1.5];
//    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
//    //下面设置delegate为self，执行摇一摇成功的回调，不执行回调可以设为nil
//    [UMSocialShakeService setShakeToShareWithTypes:nil
//                                         shareText:shareText
//                                      screenShoter:[UMSocialScreenShoterDefault screenShoter]
//                                  inViewController:self
//                                          delegate:self];
//}

@end
