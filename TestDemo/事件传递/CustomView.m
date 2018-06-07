//
//  CustomView.m
//  TestDemo
//
//  Created by Jack on 2018/4/10.
//  Copyright © 2018年 Jack. All rights reserved.
//  要想处理view的触摸事件就必须自定义view

#import "CustomView.h"

@implementation CustomView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸黄色的view");
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"触摸黄色的view%@",[super hitTest:point withEvent:event]);
//    return [super hitTest:point withEvent:event];
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor (context, 142.0/ 255.0, 161.0/ 255.0, 189.0/ 255.0, 1.0);
    CGContextSetLineWidth(context, 10.0 );//这里设置成了1但画出的线还是2px,给我们的感觉好像最小只能是2px。
    CGContextMoveToPoint(context, 1.0 , 24.0 );
    CGContextAddLineToPoint(context, 83.0 , 24.0 );
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
