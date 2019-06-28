//
//  ForwardInvocationViewController.m
//  Method_Nature_Demo
//
//  Created by Jack on 2019/6/6.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "ForwardInvocationViewController.h"
#import "AspectProxy.h"
#import "AuditingInvoker.h"
#import "Student.h"

@interface ForwardInvocationViewController ()

@end

@implementation ForwardInvocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id student = [[Student alloc] init];
    
    // 设置代理中注册的选择器数组
    NSValue *selValue1 = [NSValue valueWithPointer:@selector(study:andRead:)];
    NSArray *selValues = @[selValue1];
    // 创建AuditingInvoker
    AuditingInvoker *invoker = [[AuditingInvoker alloc] init];
    // 创建Student对象的代理studentProxy
    id studentProxy = [[AspectProxy alloc] initWithObject:student selectors:selValues andInvoker:invoker];
    
    // 使用指定的选择器向该代理发送消息---例子1
    [studentProxy study:@"Computer" andRead:@"Algorithm"];
    
    // 使用还未注册到代理中的其他选择器，向这个代理发送消息！---例子2
    [studentProxy study:@"mathematics" :@"higher mathematics"];
    
    // 为这个代理注册一个选择器并再次向其发送消息---例子3
    [studentProxy registerSelector:@selector(study::)];
    [studentProxy study:@"mathematics" :@"higher mathematics"];
    
    NSArray *array = @[@"1"];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:@"123", nil];
    void(^block)(void) = ^{
        NSLog(@"array %@",array);
        NSLog(@"mutableArray %@",mutableArray);
    };
    array = @[@"2"];
    [mutableArray addObject:@"456"];
    block();
}

@end
