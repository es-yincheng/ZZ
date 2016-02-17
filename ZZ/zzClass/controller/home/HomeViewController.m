//
//  HomeViewController.m
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [MobClick beginLogPageView:[self getControllerName]];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self getControllerName]];
}

-(void)setCustomView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JumpTo:) name:@"jmpfromhomevc" object:nil];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"home";
    
    [self setCommonSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fromTarget:(id)target toController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)JumpTo:(NSNotification *)notification
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    UIViewController *controller = [notification object];
    [self.navigationController pushViewController:controller animated:NO];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
