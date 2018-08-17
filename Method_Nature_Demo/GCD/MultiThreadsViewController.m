//
//  MultiThreadsViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "MultiThreadsViewController.h"
#import "MultiThreads.h"

@interface MultiThreadsViewController ()

@end

@implementation MultiThreadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"1");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
//        NSLog(@"3");
//    });
    
    NSLog(@"1---%@",[NSThread currentThread]);
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2---%@",[NSThread currentThread]);
    });
//    NSLog(@"3");
    
//    [[MultiThreads new] testGCDSemaphore];
    
}

@end
