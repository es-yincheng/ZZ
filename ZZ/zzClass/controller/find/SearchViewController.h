//
//  SearchViewController.h
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFTagCloudView.h"

@interface SearchViewController : UIViewController<RFTagCloudPageViewDelegate>

@property (nonatomic, strong) RFTagCloudView *tagView;

@end
