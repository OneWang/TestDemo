//
//  SubView.m
//  TestDemo
//
//  Created by Jack on 2018/4/10.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "SubView.h"

@implementation SubView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"看看是不是先调用的子控件");
    return [super hitTest:point withEvent:event];
}

@end
