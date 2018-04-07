//
//  HeightLevelCornerViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "HeightLevelCornerViewController.h"

@interface HeightLevelCornerViewController ()

@end

@implementation HeightLevelCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)drawCurveCorner{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
    //    imageView.image = [image cutCircleImage];
    imageView.image = image;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    [self.view addSubview:imageView];
    
//    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
//    imageview.center = self.view.center;
//    imageview.image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
//    //开始对imageView进行画图
//    UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, true, 0);
//    //使用贝塞尔曲线画出一个圆形图
//    [[UIBezierPath bezierPathWithOvalInRect:imageview.bounds] addClip];
//    [imageview drawRect:imageview.bounds];
//    imageview.image = UIGraphicsGetImageFromCurrentImageContext();
//    //结束画图
//    UIGraphicsEndImageContext();
//    [self.view addSubview:imageview];
//    [[UIColor whiteColor] setFill];
//    UIRectFill(imageView.bounds);
}

@end
