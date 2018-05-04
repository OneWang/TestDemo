//
//  UIImage+CutImage.m
//  TestDemo
//
//  Created by Jack on 2018/5/4.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "UIImage+CutImage.h"

@implementation UIImage (CutImage)
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
//    [self drawInRect:rect];
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:self].CGColor);
    
    //添加边框
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(rect.size.width / 2, rect.size.width / 2)];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
