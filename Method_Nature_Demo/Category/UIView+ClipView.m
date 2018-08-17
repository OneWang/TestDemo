//
//  UIView+ClipView.m
//  TestDemo
//
//  Created by Jack on 2018/1/19.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "UIView+ClipView.h"
#import <objc/runtime.h>

static void *image_borderWidthKey = "image_borderWidthKey";

@implementation UIView (ClipView)

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, image_borderWidthKey) doubleValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, image_borderWidthKey, @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)layoutSubviews{
//    NSLog(@"%s===%f",__func__,self.borderWidth);
}

- (void)clipRoundCornerRadius:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
