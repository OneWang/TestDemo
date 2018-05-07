//
//  UIImage+CutImage.m
//  TestDemo
//
//  Created by Jack on 2018/5/4.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "UIImage+CutImage.h"
#import <objc/runtime.h>

static void *image_borderColorKey = "image_borderColorKey";
static void *image_borderWidthKey = "image_borderWidthKey";

@implementation UIImage (CutImage)

- (CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, image_borderWidthKey) doubleValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    objc_setAssociatedObject(self, image_borderWidthKey, @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)borderColor{
    UIColor *color = objc_getAssociatedObject(self, image_borderColorKey);
    if (color) {
        return color;
    }
    return [UIColor whiteColor];
}

- (void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, image_borderColorKey, borderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    // 裁剪
    CGContextClip(context);
    // 将图片画上去
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:self].CGColor);
    
    //添加边框
    UIColor *color = self.borderColor;
    CGFloat width = self.borderWidth;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect.size.width / 2, rect.size.width / 2)];
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)test{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor (context, 142.0/ 255.0, 161.0/ 255.0, 189.0/ 255.0, 1.0);
    CGContextSetLineWidth(context, 1.0 );//这里设置成了1但画出的线还是2px,给我们的感觉好像最小只能是2px。
    CGContextMoveToPoint(context, 1.0 , 24.0 );
    CGContextAddLineToPoint(context, 83.0 , 24.0 );
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
