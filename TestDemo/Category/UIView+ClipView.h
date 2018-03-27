//
//  UIView+ClipView.h
//  TestDemo
//
//  Created by Jack on 2018/1/19.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ClipView)

/** 边框宽度 */
@property (assign, nonatomic) CGFloat borderWidth;

- (void)clipRoundCornerRadius:(CGFloat)cornerRadius rectCorners:(UIRectCorner)rectCorner;

@end
