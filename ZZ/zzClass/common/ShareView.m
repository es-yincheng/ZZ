//
//  ShareView.m
//  ZZ
//
//  Created by cheng yin on 15/12/24.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "ShareView.h"
#import "UMSocial.h"
#import "UMSocialScreenShoter.h"

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame AboveWindow:(UIWindow*)wind
{
    self.wind = wind;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareThisView)];
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetag)];
        
        _shareImage = [[UIImageView alloc] init];
        _shareImage.backgroundColor = [UIColor clearColor];
        //添加边框
         CALayer * layer = [_shareImage layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 3.0f;
        //添加四个边阴影
        _shareImage.layer.shadowColor = [UIColor blackColor].CGColor;
        _shareImage.layer.shadowOffset = CGSizeMake(0, 0);
        _shareImage.layer.shadowOpacity = 0.5;
        _shareImage.layer.shadowRadius = 10.0;
        _shareImage.layer.masksToBounds = YES;
        _shareImage.layer.cornerRadius = 5;
        //添加两个边阴影
        _shareImage.layer.shadowColor = [UIColor blackColor].CGColor;
        _shareImage.layer.shadowOffset = CGSizeMake(4, 4);
        _shareImage.layer.shadowOpacity = 0.5;
        _shareImage.layer.shadowRadius = 2.0;

        _shareImage.userInteractionEnabled = YES;
        [_shareImage addGestureRecognizer:imageTap];
        
        [self addSubview:_shareImage];
        
        _shareIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"];
        _shareIcon.image = [UIImage imageWithContentsOfFile:path];
        [self addSubview:_shareIcon];
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    //    self.backgroundColor = [UIColor redColor];
    //    self.hidden = NO;
    NSLog(@"检测到截屏");
  
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    _shareImage.image = image_;
    _shareImage.frame = CGRectMake(_shareIcon.frame.origin.x+5, CGRectGetMaxY(_shareIcon.frame)-5, _shareIcon.frame.size.width-10, (_shareIcon.frame.size.width-10)*image_.size.height/image_.size.width);
    
    self.hidden = NO;
    [self.wind bringSubviewToFront:self];
    [self performSelector:@selector(viewHidden) withObject:nil afterDelay:4];
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}



-(void)shareThisView
{
    [self viewHidden];
    YCLog(@"I will share this screenshotpic");
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    [UMSocialSnsService presentSnsIconSheetView:[self getCurrentVC] appKey:YOUMENGAPK shareText:@"分享文字" shareImage:image shareToSnsNames:nil delegate:nil];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
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
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)imagetag
{
    YCLog(@"I did tap image");
}

-(void)viewHidden
{
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:3];
    
    [self setHidden:YES];
    
    [UIView commitAnimations];
}

@end
