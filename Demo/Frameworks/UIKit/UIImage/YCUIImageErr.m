//
//  YCUIImageErr.m
//  ZZ
//
//  Created by cheng yin on 15/12/24.
//  Copyright © 2015年 cheng yin. All rights reserved.
//

#import "YCUIImageErr.h"
#import "HeaderView.h"

@interface YCUIImageErr ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isOpen;
    NSInteger selectIndex;
}
/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *SectionArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YCUIImageErr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomView];
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
    return self.SectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self.SectionArray[section] objectForKey:@"sname"];
    HeaderView *header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCRENW, 44)];
    [header updateWith:title WithStatus:isOpen];
    header.block =^{
        selectIndex = section;
        isOpen =! isOpen;
//        [_sectionStatus replaceObjectAtIndex:section withObject:num];
        //重新加载当前区
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
//        UITableViewRowAnimationFade,
//        UITableViewRowAnimationRight,           // slide in from right (or out to right)
//        UITableViewRowAnimationLeft,
//        UITableViewRowAnimationTop,
//        UITableViewRowAnimationBottom,
//        UITableViewRowAnimationNone,            // available in iOS 3.0
//        UITableViewRowAnimationMiddle,
    };
    header.backgroundColor = [UIColor greenColor];
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOpen && selectIndex == section) {
        return 3;
    }
    return 0;
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
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

#pragma mark - getter
-(NSArray*)SectionArray
{
    if (!_SectionArray) {
        NSArray *sections = @[@{@"sname":@"基本属性和方法"},@{@"sname":@"基本方法"},@{@"sname":@"常见问题"}];
        _SectionArray = [NSMutableArray arrayWithArray:sections];
    }
    return _SectionArray;
}

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
