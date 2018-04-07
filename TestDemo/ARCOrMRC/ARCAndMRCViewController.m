//
//  ARCAndMRCViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ARCAndMRCViewController.h"

@interface ARCAndMRCViewController ()

@end

__weak NSString *string_weak = nil;
@implementation ARCAndMRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSString *string = [NSString stringWithFormat:@"jackonewang"];
//    string_weak = string;

//    @autoreleasepool{
//        NSString *string = [NSString stringWithFormat:@"jackonewang"];
//        string_weak = string;
//    }
    
    NSString *string = nil;
    @autoreleasepool{
        string = [NSString stringWithFormat:@"jackonewang"];
        string_weak = string;
    }
    
    NSLog(@"%@==",string_weak);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s----%@",__func__,string_weak);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s----%@",__func__,string_weak);
}

//测试两个字符串的初始化
- (void)testStringAddress{
    NSString *str1 = @"123";
    NSString *str2 = [NSString stringWithFormat:@"%@",@"123"];
    if (str1 == str2) {
        NSLog(@"as");
    }else{
        NSLog(@"sdf");
    }
}

@end
