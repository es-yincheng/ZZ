//
//  SearchViewController.m
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "SearchViewController.h"
#import "RFTagCloudView.h"

@interface SearchViewController ()

{
    NSArray *words;
    NSArray *colorArray;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustmView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[self getControllerName]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self getControllerName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 自定义
-(void)setCustmView
{
    self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view blurWithImageName:@"back_searchvc" alpha:0.5];
//    [self.view blurWithGif:@"back_search" alpha:0.5];
    [self getData];
    [self addView];
    [self setViewFram];
}

-(void)addView
{
    [self.view addSubview:self.tagView];
}

-(void)setViewFram
{
//    self.tagView.frame = CGRectMake(0, NAVH, SCRENW, SCRENW);
}


-(void)getData
{
        colorArray=@[RGB(51, 51, 51),RGB(102, 102, 102),RGB(102, 153, 0),RGB(0, 153, 255),RGB(255, 102, 0),RGB(255, 51, 51)];
        words = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"海贼王",@"会说话的汤姆猫",@"大头儿子小头爸爸",@"少林足球",@"妖精的尾巴",@"咸蛋超人",@"蜘蛛侠",@"葫芦娃",@"北京",@"火影忍者",@"足球小子",@"超人",@"葫芦娃大战蜘蛛精",@"super man",@"北京",@"火影忍者",@"足球小子",@"超人",@"葫芦娃大战蜘蛛精",@"super  man",@"welcome to china",@"上海",@"海贼王",@"会说话的汤姆猫",@"大头儿子小头爸爸",@"少林足球",@"妖精的尾巴",@"咸蛋超人",@"蜘蛛侠",@"葫芦娃",@"北京",@"火影忍者",@"足球小子",@"超人",@"葫芦娃大战蜘蛛精",@"super man"];
}

#pragma mark - getter
-(RFTagCloudView*)tagView
{
    if (!_tagView) {
        _tagView = [[RFTagCloudView alloc] initWithFrame:CGRectMake(0, NAVH, SCRENW, SCRENH-NAVH-TABBAR)];
        _tagView.delegate = self;
        [_tagView drawCloudWithWords:words colors:colorArray rowHeight:30];
    }
    return _tagView;
}
@end
