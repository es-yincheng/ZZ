//
//  ClassicCaseViewController.m
//  ZZ
//
//  Created by cheng yin on 15/12/25.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "ClassicCaseViewController.h"

@interface ClassicCaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *CasesArray;
@end

@implementation ClassicCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[self getControllerName]];//("PageOne"为页面名称，可自定义)
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



#pragma mark - delegate dataSourced
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"youCell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    cell.textLabel.text = [self.classesArray objectAtIndex:indexPath.row-1];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class c = NSClassFromString([NSString stringWithFormat:@"YC%@",[self.classesArray objectAtIndex:indexPath.row-1]]);
    UIViewController *viewctroller = [[c alloc] init];
    [self.navigationController pushViewController:viewctroller animated:YES];
}

#pragma mark - 自定义方法
-(void)setCustomView
{
    [self setCommonSetting];
    [self.view blurWithImageName:nil alpha:1.0];
    [self.view addSubview:self.tableView];
}

-(void)loadData
{
    
}

#pragma mark - getter

-(NSMutableArray*)classesArray
{
    if (!_CasesArray) {
        _CasesArray = [NSMutableArray arrayWithArray:@[@"AddressPickerVC"]];
    }
    return _CasesArray;
}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
