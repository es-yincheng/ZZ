//
//  HeaderView.h
//
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface HeaderView : UIView

@property(nonatomic,copy)TapBlock block;


-(void)updateWith:(NSString *)title WithStatus:(BOOL)status;

@end
