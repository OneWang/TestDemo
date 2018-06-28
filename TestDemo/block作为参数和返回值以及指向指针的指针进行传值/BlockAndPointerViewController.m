//
//  BlockAndPointerViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BlockAndPointerViewController.h"
#import "BlockAndPointer.h"

typedef void(^block)(NSString *);

@interface BlockAndPointerViewController ()

@end

@implementation BlockAndPointerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BlockAndPointer *test = [[BlockAndPointer alloc] init];
    
    NSInteger number = 10;
    void(^block)(NSString *) = ^(NSString *string){
        NSLog(@"%ld===",number);
    };
    
    NSLog(@"%@",block);
    
    block(@"asd");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
