//
//  AutoLayoutViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AutoLayoutViewController.h"
#import <Masonry.h>

@interface AutoLayoutViewController ()

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    label1.adjustsFontSizeToFitWidth = YES;
    label1.text = @"解决扩UK接口asfdsfadfa";
    
    UILabel *label2 = [[UILabel alloc] init];
    [self.view addSubview:label2];
    label2.adjustsFontSizeToFitWidth = YES;
    label2.text = @"是否是第几集温热无热无若";
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(150);
        make.right.equalTo(label2.mas_left).offset(-10);
        make.height.equalTo(@21);
    }];

    [label1 setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    [label1 setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(10);
        make.top.equalTo(self.view).offset(150);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@21);
    }];
}

@end
