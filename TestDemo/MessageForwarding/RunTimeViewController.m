//
//  RunTimeViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/30.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "RunTimeViewController.h"
#import "NSObject+Sark.h"

@interface RunTimeViewController ()

@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSObject foo];
    [[NSObject new] performSelector:@selector(foo)];
}

@end
