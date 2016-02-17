//
//  YCTool.h
//  ZZ
//
//  Created by cheng yin on 15/12/30.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCTool : NSObject

/**
 *  获取当前显示viewController
 *
 *  @return 当前显示viewController
 */
+ (UIViewController *)getCurrentVC;


//+(BOOL)currentVCisHomeVC;


+(UIViewController *)getPresentedViewController;

@end
