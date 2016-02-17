//
//  YCRootViewController.h
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCLeftViewController.h"
#import "HomeViewController.h"

@interface YCRootViewController : UIViewController

@property (assign,nonatomic) BOOL needSwipeShowMenu;//是否开启手势滑动出菜单

@property (retain,nonatomic) UITabBarController *rootViewController;
@property (retain,nonatomic) YCLeftViewController *leftViewController NS_AVAILABLE_IOS(5_0);
@property (retain,nonatomic) UIViewController *rightViewController NS_AVAILABLE_IOS(5_0);
@property (retain,nonatomic) UINavigationController *homeNAV NS_AVAILABLE_IOS(5_0);

@property (assign,nonatomic) CGFloat leftViewShowWidth;//左侧栏的展示大小
@property (assign,nonatomic) CGFloat rightViewShowWidth;//右侧栏的展示大小

@property (assign,nonatomic) NSTimeInterval animationDuration;//动画时长
@property (assign,nonatomic) BOOL showBoundsShadow;//是否显示边框阴影

//@property (copy,nonatomic) RootViewMoveBlock rootViewMoveBlock;//可在此block中重做动画效果
//- (void)setRootViewMoveBlock:(RootViewMoveBlock)rootViewMoveBlock;

- (void)showLeftViewController:(BOOL)animated;//展示左边栏
- (void)showRightViewController:(BOOL)animated;//展示右边栏
- (void)hideSideViewController:(BOOL)animated;//恢复正常位置

@end
