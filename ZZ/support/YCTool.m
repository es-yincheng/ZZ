//
//  YCTool.m
//  ZZ
//
//  Created by cheng yin on 15/12/30.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "YCTool.h"
#import "HomeViewController.h"

@implementation YCTool

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:1];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    YCLog(@"class name>>》》》》》》》》》》》》》》》》》\n %@",NSStringFromClass([nextResponder class]));
    return result;
}



//+(BOOL)currentVCisHomeVC
//{
//    BOOL isHomeVC  = [[self getCurrentVC] isKindOfClass:[HomeViewController class]];
//    if (isHomeVC) {
//        YCLog(@"ishomevc");
//    } else {
//        YCLog(@"nothomevc");
//    }
////    YCLog(@"isHomeVC : %@",isHomeVC);
//    return [[self getCurrentVC] isKindOfClass:[HomeViewController class]];
//}

+(UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    YCLog(@"class name>>》》》》》》》》》》》》》》》》》\n %@",NSStringFromClass([topVC class]));
    return topVC;
}

//Objective-C中获取类名
//很方便的调试及日志工具
//NSLog(@"class name>> %@",NSStringFromClass([self class]));


//判断对象是否是x类的实体类
//[object isKindOfClass:[NSObject class]];
//返回值是BOOL类型
//
//NSObject替换成你想要的类名就可以了

// 三目运算符
//j < (N - 1) ? (j++,i = 0):0
@end
