//
//  CustomView.m
//  TestDemo
//
//  Created by Jack on 2018/4/10.
//  Copyright © 2018年 Jack. All rights reserved.
//  要想处理view的触摸事件就必须自定义view

#import "CustomView.h"

@implementation CustomView

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"调用黄色的view");
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"调用黄色的view");
    return [super hitTest:point withEvent:event];
}

@end

@implementation RedView
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"触摸红色的view");
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触摸红色的view");
    return [super hitTest:point withEvent:event];
}
@end

@implementation BlueView
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"触摸蓝色的view");
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"触摸蓝色的view");
    return [super hitTest:point withEvent:event];
}
@end
