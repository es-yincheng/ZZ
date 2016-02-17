//
//  YCSliderViewController.m
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "YCLeftViewController.h"
#import "LeftViewCell.h"

@interface YCLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YCLeftViewController
{
    NSArray *cellImageArray;
    NSArray *cellTitleArray;
//    NSArray *cellControllerArray;
    UIImageView *leftbackImgView;
//    UITableView *tabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomView];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    cellImageArray = @[@"bolt_32x32",@"calendar_alt_stroke_32x32",@"chat_32x32"];
    cellTitleArray = @[@"基础类的使用",@"经典案例",@"常见问题"];
    _cellControllerArray = @[@"BaseClassViewController",@"ClassicCaseViewController",@"FAQViewController"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:[self getControllerName]];
    NSInteger picIndex = arc4random_uniform(cellImageArray.count);
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"left_back_%ld",(long)picIndex] ofType:@"png"];
    leftbackImgView.image = [UIImage imageWithContentsOfFile:path];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self getControllerName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - delegate , datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellTitleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftViewCell *cell = [LeftViewCell cellWithTableView:_tableView];
    cell.pic.image = [UIImage imageNamed:[cellImageArray objectAtIndex:indexPath.row]];
    cell.name.text = [cellTitleArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - 自定义

- (void)setCustomView
{
    leftbackImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:leftbackImgView];
    
    UIBlurEffect *blureff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc ] initWithEffect:blureff];
    visualEffect.frame = leftbackImgView.frame;
//    visualEffect.alpha = 0.9;
    [leftbackImgView addSubview:visualEffect];
    
    
    [self addView];
    [self setFram];
}

/**
 *  向view上添加控件
 */
-(void)addView
{
    [self.view addSubview:self.userCenterHeader];
}

/**
 *  设置控件fram
 */
-(void)setFram
{
//    self.userCenterHeader.frame = CGRectMake(0, 0, self.view.bounds.size.width/5*3, 60);
}

#pragma mark - getter

- (UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 220, 200, SCRENH-2*120)];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        //设置代理
//        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UserCenterHeader*)userCenterHeader
{
    if (!_userCenterHeader) {
        _userCenterHeader = [[UserCenterHeader alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width/3*2, 200)];
    }
    return _userCenterHeader;
}

@end
