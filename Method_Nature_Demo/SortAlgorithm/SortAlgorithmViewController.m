//
//  SortAlgorithmViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "SortAlgorithmViewController.h"
#import "SortAlgorithm.h"

@interface SortAlgorithmViewController ()

@end

@implementation SortAlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SortAlgorithm *algorithm = [[SortAlgorithm alloc] init];
    NSLog(@"%@",algorithm);
    NSLog(@"%d",findMaxSubstring(@"abcda"));
    self.view.backgroundColor = [UIColor redColor];
    
}

@end
