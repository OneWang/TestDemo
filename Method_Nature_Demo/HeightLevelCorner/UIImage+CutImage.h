//
//  UIImage+CutImage.h
//  TestDemo
//
//  Created by Jack on 2018/5/4.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CutImage)

/** 边框宽度 */
@property (assign, nonatomic) CGFloat borderWidth;
/** 边框颜色 */
@property (strong, nonatomic) UIColor *borderColor;

- (UIImage *)cutCircleImage;
@end
