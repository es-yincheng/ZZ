//
//  LeftViewCell.h
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView *pic;
@property(nonatomic, strong)UILabel *name;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
