//
//  UIView+YCBlur.h
//  ZZ
//
//  Created by cheng yin on 15/12/25.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YCBlur)

/**
*  使用图片讲view毛玻璃化
*
*  @param image 毛玻璃背景图片
*  @param alpha 透明度
*/
-(void)blurWithImageName:(NSString *)image alpha:(float)alpha;


-(void)blurWithGif:(NSString *)gif alpha:(float)alpha;

@end
