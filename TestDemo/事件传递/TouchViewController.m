//
//  TouchViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/10.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "TouchViewController.h"
#import "CustomView.h"
#import "SubView.h"

@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:custom];
    custom.backgroundColor = [UIColor yellowColor];
    
    RedView *red = [[RedView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [custom addSubview:red];
    red.userInteractionEnabled = NO;
    red.backgroundColor = [UIColor redColor];
    
    BlueView *blue = [[BlueView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
    [red addSubview:blue];
    blue.backgroundColor = [UIColor blueColor];
    /**
     总结：无论视图能不能处理事件，只要点击了视图就都会产生事件，关键在于该事件最终是由谁来处理！
     */
}

@end
