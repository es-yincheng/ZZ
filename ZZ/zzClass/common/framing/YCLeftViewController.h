//
//  YCSliderViewController.h
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterHeader.h"

@interface YCLeftViewController : UIViewController
/**
 *  用户信息部分
 */
@property (nonatomic, strong) UserCenterHeader *userCenterHeader;

@property (nonatomic, strong) UITableView *tableView;

/**
 *  <#Description#>
 */
@property (nonatomic, strong) NSArray *cellControllerArray;
@end
