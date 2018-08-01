//
//  CustomView.m
//  TestDemo
//
//  Created by Jack on 2018/4/10.
//  Copyright © 2018年 Jack. All rights reserved.
//  要想处理view的触摸事件就必须自定义view

#import "CustomView.h"

@implementation CustomView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸黄色的view");
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"触摸黄色的view%@",[super hitTest:point withEvent:event]);
//    return [super hitTest:point withEvent:event];
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//内存恶鬼；寄宿图的生成
/**
 因为重写了-drawRect：方法，-drawRect：方法就会自动调用，生成一张寄宿图后，方法里面的代码利用Core Graphics去绘制n条黑色的线，然后内容就会缓存起来，等待下次你调用-setNeedsDisplay时再进行更新；  
 
 画板视图的-drawRect：方法的背后实际上都是底层的CALayer进行了重绘和保存中间产生的图片，CALayer的delegate属性默认实现了CALayerDelegate协议，当它需要内容信息的时候会调用协议中的方法来拿，当画板视图重绘时，因为它的支持图层CALayer的代理就是画板视图本身，所以支持图层会请求画板视图给它一个寄宿图来显示；它此刻会调用：- (void) displayLayer:(CALayer *)layer;
 
 如果画板视图实现了这个方法，就可以拿到layer来直接设置contents寄宿图，如果这个方法没有实现，支持图层CALayer会尝试调用：- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
 
 在这个方法调用之前，CALayer创建一个合适尺寸的空寄宿图（尺寸由bounds和contentsScale决定）和一个Core Graphics的绘制上下文环境，为绘制寄宿图做准备，它作为ctx参数传入；在这一步生成的空寄宿图内存相当巨大的，它就是本次内存问题的关键，一旦你实现了CALayerDelegate协议中的-drawLayer:inContext: 方法或者UIView中的-drawRect:方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的内存可从这个公式得出：图层宽*图层高*4字节；宽高的单位均为像素；而我们的画板程序因为要支持两指挪动的效果，所以问开辟的画板大小是屏幕宽高的2倍；图层每次重绘的时候都需要重新抹掉内存然后重新绘制；它就是我们画板程序内存暴增的真正原因；
 */
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor (context, 142.0/ 255.0, 161.0/ 255.0, 189.0/ 255.0, 1.0);
    CGContextSetLineWidth(context, 10.0 );//这里设置成了1但画出的线还是2px,给我们的感觉好像最小只能是2px。
    CGContextMoveToPoint(context, 1.0 , 24.0 );
    CGContextAddLineToPoint(context, 83.0 , 24.0 );
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
