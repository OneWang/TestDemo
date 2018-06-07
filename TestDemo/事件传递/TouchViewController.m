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
#import "Aview.h"
#import "Bview.h"
#import "Cview.h"
#import "Dview.h"

@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    Aview *red = [[Aview alloc] initWithFrame:CGRectMake(100, 100, 100, 300)];
    [self.view addSubview:red];
    red.backgroundColor = [UIColor redColor];
    
    Bview *blue = [[Bview alloc] initWithFrame:CGRectMake(0, 30, 50, 50)];
    [red addSubview:blue];
    blue.backgroundColor = [UIColor blueColor];
    
    Cview *yellow = [[Cview alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    [red addSubview:yellow];
    yellow.backgroundColor = [UIColor yellowColor];
    
    Dview *orange = [[Dview alloc] initWithFrame:CGRectMake(0, 20, 70, 70)];
    [yellow addSubview:orange];
    orange.backgroundColor = [UIColor orangeColor];
    /**
     总结：无论视图能不能处理事件，只要点击了视图就都会产生事件，关键在于该事件最终是由谁来处理！
     */
}

@end
