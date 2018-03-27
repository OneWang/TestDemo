//
//  UIViewController+viewdidload.m
//  Demo
//
//  Created by Jack on 2018/3/9.
//  Copyright © 2018年 forkingdog. All rights reserved.
//

#import "UIViewController+viewdidload.h"
#import <objc/runtime.h>

typedef void(*VIMP)(id,SEL, ...);

@implementation UIViewController (viewdidload)

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        //获取原始方法
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        //获取方法的实现
//        VIMP viewDidLoad_imp = (VIMP)method_getImplementation(viewDidLoad);
//        //重新设置方法实现
//        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target){
//            //调用原来的方法
//            viewDidLoad_imp(target,@selector(viewDidLoad));
//            //新增代码
//            NSLog(@"bbbbbbbbbbbbb%@", target);
//        }));
//    });
//}

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method methodA = class_getInstanceMethod(self, @selector(viewDidLoad));
//        Method methodB = class_getInstanceMethod(self, @selector(new_viewdidLoad));
//
//        //当前方法是否添加成功
//        BOOL isAddSuccessful = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(methodB), method_getTypeEncoding(methodB));
//        if (isAddSuccessful) {
//            //如果成功的话就去替换掉
//            class_replaceMethod([self class], @selector(new_viewdidLoad), method_getImplementation(methodA), method_getTypeEncoding(methodB));
//        }else{
//            //没有成功的话就直接交换
//            method_exchangeImplementations(methodA, methodB);
//        }
//
//    });
//}

- (void)new_viewdidLoad{
    [self new_viewdidLoad];
    NSLog(@"%@ did load",self);
}

@end
