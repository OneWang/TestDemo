//
//  UIView+Addition.h
//  TestDemo
//
//  Created by Jack on 2018/3/29.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
- (CGFloat)left;
- (CGFloat)top;
- (CGFloat)right;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGPoint)origin;
- (CGSize)size;

- (void)setLeft:(CGFloat)x;
- (void)setTop:(CGFloat)y;
- (void)setRight:(CGFloat)right;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;
@end
