//
//  Aview.m
//  TestDemo
//
//  Created by Jack on 2018/6/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "Aview.h"

@interface Aview ()

@end

@implementation Aview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        [self addSubview:label];
        label.text = NSStringFromClass([self class]);
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@--%s",NSStringFromClass([self class]),__func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@--%s",NSStringFromClass([self class]),__func__);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@进入--%s",NSStringFromClass([self class]),__func__);
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"%@离开--%s--%@",NSStringFromClass([self class]),__func__,view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@--%s",NSStringFromClass([self class]),__func__);
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"%@--%s--isInside:%d",NSStringFromClass([self class]),__func__,isInside);
    return isInside;
}

@end
