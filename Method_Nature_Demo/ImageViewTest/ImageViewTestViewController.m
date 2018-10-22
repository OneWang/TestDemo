//
//  ImageViewTestViewController.m
//  TestDemo
//
//  Created by Jack on 2018/7/2.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ImageViewTestViewController.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageViewTestViewController ()
/** 测试图片 */
@property (nonatomic, strong) UIImageView *testImageView;
@end

@implementation ImageViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *testImageView = [[UIImageView alloc] init];
    [self.view addSubview:testImageView];
    [testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    UIImage *testImage = [UIImage imageNamed:@"photo_sel_photoPickerVc"];
    NSData *testData = UIImageJPEGRepresentation(testImage, 1.f);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"photo_sel_photoPickerVc.jpg"];
    [manager createFileAtPath:path contents:testData attributes:nil];
    
    //第一种方法：在后面修改图片的话会影响前面已经显示的图片
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    //第二种方法：通过data在中间转换一下，就不会显示前面已经渲染好的图片了
//    NSData *tempData = [[NSData alloc] initWithContentsOfFile:path];
//    UIImage *image = [UIImage imageWithData:tempData];
    testImageView.image = image;
    
    UIImage *newtestImage = [UIImage imageNamed:@"photo_def_photoPickerVc"];
    NSData *newData = UIImageJPEGRepresentation(newtestImage, 1.f);
    [manager createFileAtPath:path contents:newData attributes:nil];
    
    /*
     如果已经显示了一张沙盒里的图片，这个时候对相同路径的文件进行修改和删除，通常我们认为_imageView应该不受到影响，因为图片已经完成渲染，但事实并非如此，_imageView竟然会跟着发生变化，并且变化的结果也是不可预期的，比如说删除对应的路径的文件，_imageView可能全部黑屏或者一些黑屏，如果不想因为后续操作而影响_imageView的显示，那么就需要用NSData中转一下；其实内部是为了性能考虑。内部会有一些同步机制；
     **/
    
    //关于SDWebImage的测试
    _testImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 250, 250)];
    [self.view addSubview:_testImageView];
//    __weak __typeof(self)weakSelf = self;
    [_testImageView sd_setImageWithURL:[NSURL URLWithString:@"https://img-bbs.csdn.net/upload/201409/25/1411609399_863397.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        image = [self getSubImage:CGRectMake(0, 0, 100, 100) andImage:image];
//        UIImageView *testImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//        [self.view addSubview:testImage];
//        testImage.image = image;
        self.testImageView.image = image;
    }];
}

// 图片裁剪
- (UIImage *)getSubImage:(CGRect)rect andImage:(UIImage *)image{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

- (void)dealloc{
    NSLog(@"销毁了！");
}

@end
