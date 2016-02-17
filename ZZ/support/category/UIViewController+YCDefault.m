//
//  UIViewController+YCDefault.m
//  ZZ
//
//  Created by cheng yin on 15/12/30.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "UIViewController+YCDefault.h"

@implementation UIViewController (YCDefault)

-(void)setCommonSetting
{
    //controller的统一设置
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture)];
}

-(void)handleGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getControllerName
{
    return NSStringFromClass([self class]);
}

@end
