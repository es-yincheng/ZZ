//
//  YCUIImage.m
//  ZZ
//
//  Created by cheng yin on 15/12/24.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "YCUIImage.h"
#import "HeaderView.h"

@interface YCUIImage ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isOpen;
    NSInteger selectIndex;
}
/**
 *  数据源
 */
//@property (nonatomic, strong) NSMutableArray *SectionArray;
@property (nonatomic, strong) UITableView *tableView;
//数据源
@property(nonatomic)NSMutableArray *data;

//开关状态
@property(nonatomic)NSMutableArray *sectionStatus;

//每个区的标题
@property(nonatomic)NSMutableArray *titles;
@end

@implementation YCUIImage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomView];
    [self createData];
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
    
}

#pragma mark - delegate source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = _titles[section];
    HeaderView *header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    BOOL status = [_sectionStatus[section] boolValue];
    [header updateWith:title WithStatus:status];
    header.block =^{
        NSNumber *num = status? @0 :@1;
        [_sectionStatus replaceObjectAtIndex:section withObject:num];
        //重新加载当前区
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_sectionStatus[section] isEqualToNumber:@0]) {
        return 0;
    }
    return [_data[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _data[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    YCLog(@"sdf");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 自定义方法
/**
 *  初始化界面
 */
-(void)setCustomView
{
    [self.view addSubview:self.tableView];
}

-(void)createData
{
    //初始化每个区的开关状态
    _sectionStatus = [[NSMutableArray alloc] init];
    _data = [[NSMutableArray alloc] init];
    NSArray *arr = @[@"分组1",@"分组2",@"分组3",@"分组4"];
    _titles = [[NSMutableArray alloc] initWithArray:arr];
    for (NSString *name in arr) {
        NSMutableArray *ac = [NSMutableArray array];
        for (NSInteger i = 0; i <10; i++) {
            NSString *str = [NSString stringWithFormat:@"%@ + %ld",name,i];
            [ac addObject:str];
        }
        [_sectionStatus addObject:@0];
        [_data addObject:ac];
    }
}

#pragma mark - getter
//-(NSArray*)SectionArray
//{
//    if (!_SectionArray) {
//        NSArray *sections = @[@{@"sname":@"基本属性和方法"},@{@"sname":@"基本方法"},@{@"sname":@"常见问题"}];
//        _SectionArray = [NSMutableArray arrayWithArray:sections];
//    }
//    return _SectionArray;
//}

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
//    UITableViewStylePlain,          // regular table view
//    UITableViewStyleGrouped         // preferences style table view
    return _tableView;
}

@end
