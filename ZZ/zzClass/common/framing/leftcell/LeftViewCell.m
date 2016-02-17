//
//  LeftViewCell.m
//  YCIOSDemo
//
//  Created by cheng yin on 15/12/16.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // NSLog(@"cellForRowAtIndexPath");
    static NSString *identifier = @"LeftViewCell";
    // 1.缓存中取
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[LeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _pic.image = [UIImage imageNamed:@"aperture_alt_32x32"];
        [self addSubview:_pic];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pic.frame)+15, _pic.frame.origin.y, 200, 25)];
        _name.textColor = [UIColor whiteColor];
        _name.text = @"Home";
        [self addSubview:_name];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
