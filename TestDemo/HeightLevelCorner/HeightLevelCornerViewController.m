//
//  HeightLevelCornerViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "HeightLevelCornerViewController.h"
#import "UIImage+CutImage.h"

@interface HeightLevelCornerViewController ()

@end

@implementation HeightLevelCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawCurveCorner];
}

- (void)drawCurveCorner{
    //方式一
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
    imageView.image = image;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    imageView.layer.borderWidth = 5.f;
    [self.view addSubview:imageView];
    
    //方式二
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    imageview.center = self.view.center;
    imageview.image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, true, 0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithOvalInRect:imageview.bounds] addClip];
    [imageview drawRect:imageview.bounds];
    imageview.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    imageview.layer.borderWidth = 5.f;
    imageview.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageview];
    [[UIColor whiteColor] setFill];
    UIRectFill(imageView.bounds);
    
    //方式三
    UIImageView *imageThreeView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 400, 100, 100)];
    UIImage *cutimage = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
    UIImage *cutImage = [cutimage cutCircleImage];
    cutImage.borderWidth = 20.f;
    cutImage.borderColor = [UIColor greenColor];
    imageThreeView.image = cutImage;
//    imageThreeView.layer.borderColor = [UIColor redColor].CGColor;
//    imageThreeView.layer.borderWidth = 5.f;
    [self.view addSubview:imageThreeView];
}

- (UIImage *)drawCircleImage:(UIImage *)image{
    CGFloat side = MIN(image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, side, side)].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    CGFloat marginX = -(image.size.width - side) * 0.5;
    CGFloat marginY = -(image.size.height - side) * 0.5;
    [image drawInRect:CGRectMake(marginX, marginY, image.size.width, image.size.height)];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
