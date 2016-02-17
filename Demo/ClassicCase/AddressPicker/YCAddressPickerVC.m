//
//  AddressPickerVC.m
//  ZZ
//
//  Created by cheng yin on 16/1/7.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "YCAddressPickerVC.h"
#import "AddressChoicePickerView.h"

@interface YCAddressPickerVC ()
@property (weak, nonatomic) IBOutlet UITextField *city;

@end

@implementation YCAddressPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAddress:(UIButton *)sender {
    AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
    addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        self.city.text = [NSString stringWithFormat:@"%@",locate];
    };
    [addressPickerView show];
}


@end
