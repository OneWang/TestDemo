//
//  MultiThreadsViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "MultiThreadsViewController.h"

@interface MultiThreadsViewController ()

@end

@implementation MultiThreadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
}

@end
