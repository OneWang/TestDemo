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
    
    NSString *string = @"";
    NSLog(@"%@",string ?: @"测试");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, 100)];
    contentView.backgroundColor = [UIColor redColor];
    contentView.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 100);
    [self.view addSubview:contentView];
    UITextField *userName = [[UITextField alloc] init];
    [contentView addSubview:userName];
    userName.placeholder = @"测试";
    userName.borderStyle = UITextBorderStyleBezel;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(contentView.mas_left).offset(38);
//        make.right.equalTo(contentView.mas_right).offset(-38);
        make.width.equalTo(@(UIScreen.mainScreen.bounds.size.width - 38 * 2));
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView);
        make.height.equalTo(@44);
    }];
    
//    UILabel *label1 = [[UILabel alloc] init];
//    [self.view addSubview:label1];
//    label1.adjustsFontSizeToFitWidth = YES;
//    label1.text = @"解决扩UK接口asfdsfadfa";
//    
//    UILabel *label2 = [[UILabel alloc] init];
//    [self.view addSubview:label2];
//    label2.adjustsFontSizeToFitWidth = YES;
//    label2.text = @"是否是第几集温热无热无若";
//    
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.top.equalTo(self.view).offset(150);
//        make.right.equalTo(label2.mas_left).offset(-10);
//        make.height.equalTo(@21);
//    }];
//
//    [label1 setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
//    [label1 setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
//    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(label1.mas_right).offset(10);
//        make.top.equalTo(self.view).offset(150);
//        make.right.equalTo(self.view).offset(-10);
//        make.height.equalTo(@21);
//    }];
}

- (instancetype)init{
    if (self = [super init]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"AutoLayoutViewController" bundle:nil];
        self = [story instantiateViewControllerWithIdentifier:@"AutoLayoutViewController"];
    }
    return self;
}

@end
