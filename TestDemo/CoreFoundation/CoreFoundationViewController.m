//
//  CoreFoundationViewController.m
//  TestDemo
//
//  Created by Jack on 2018/6/2.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "CoreFoundationViewController.h"
#import <CoreFoundation/CoreFoundation.h>

@interface CoreFoundationViewController ()


@end

@implementation CoreFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    id array = [[NSMutableArray alloc] init];
    CFMutableArrayRef cfobject = CFBridgingRetain(array);
    CFShow(cfobject);
    printf("%ld",(long)CFGetRetainCount(cfobject));
    CFRelease(cfobject);
}

- (void)normalTest{
    CFMutableArrayRef cfobject = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
    printf("转换之前：%ld\n",CFGetRetainCount(cfobject));
    
    id object = CFBridgingRelease(cfobject);
    printf("转换之后：%ld\n",CFGetRetainCount(cfobject));
    
    NSLog(@"%@\n",object);
}

//内存泄漏
- (void)test1{
    CFMutableArrayRef cfobject = CFArrayCreateMutable(kCFAllocatorDefault, 0, NULL);
    printf("转换之前：%ld\n",CFGetRetainCount(cfobject));
    
    id object = (__bridge id)cfobject;
    printf("转换之后：%ld\n",CFGetRetainCount(cfobject));
    
    NSLog(@"%@\n",object);
}

@end
