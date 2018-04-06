//
//  ViewController.m
//  TestDemo
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <Masonry.h>
#import "UIView+ClipView.h"
#import "AssetViewController.h"
#import "ItemCell.h"
#import <objc/runtime.h>
#import "UIImage+ClipVIew.h"
#import "Person.h"
#import "SortAlgorithm.h"

@interface ViewController ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionview */
@property (weak, nonatomic) UICollectionView *collectionView;
/** 照片数组 */
@property (strong, nonatomic) NSArray *photoArray;

@end

@implementation ViewController

//- (instancetype)init{
//    if (self = [super init]) {
//        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initwith" userInfo:nil];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SortAlgorithm *sort = [[SortAlgorithm alloc] init];
    NSArray *array = @[@12,@2,@23,@3,@45,@12,@9,@140].mutableCopy;
    [sort mergerSort:[NSMutableArray arrayWithArray:array] leftIndex:0 rightIndex:7];
}

//测试两个字符串的初始化
- (void)testStringAddress{
    NSString *str1 = @"123";
    NSString *str2 = [NSString stringWithFormat:@"%@",@"123"];
    if (str1 == str2) {
        NSLog(@"as");
    }else{
        NSLog(@"sdf");
    }
}

#pragma mark - block作为参数和返回值的使用
- (void)testFunction{
    [self setUpTitleEffect:^(NSString *__autoreleasing *title, CGFloat *width) {
        *title = @"我是指针的指针";
        *width = 12.5;
    }];
    
    NSString *string = @"单独的指针";
    CGFloat count = 109043.f;
    [self setupTitleWithSting:&string andWidth:&count];
}

- (void)testBlock{
    void(^testblock)(int n) = [self createFunctionWithString:^NSString *(NSArray *numarray) {
        NSMutableString *string = [NSMutableString string];
        for (NSString *str in numarray) {
            NSLog(@"%@",str);
            [string appendString:str];
        }
        return string;
    }];
    if (testblock) {
        testblock(8);
    }
}

- (void(^)(int number))createFunctionWithString:(NSString *(^)(NSArray *))stringBlock{
    if (stringBlock) {
        NSLog(@"%@",stringBlock(@[@"d",@"d"]));
    }
    return ^(int num){
        if (stringBlock) {
            NSLog(@"%@",stringBlock(@[@"嗯我若无",@"发生的",@"fas"]));
        }
    };
}

#pragma mark - 使用指向指针的指针进行传值
- (void)setUpTitleEffect:(void(^)(NSString **title,CGFloat *width))titleEffectBlock{
    NSString *title;
    CGFloat width;
    if (titleEffectBlock) {
        titleEffectBlock(&title,&width);
        NSLog(@"%@===%f",title,width);
    }
}

- (void)setupTitleWithSting:(NSString **)string andWidth:(CGFloat *)width{
    NSLog(@"%@=====%f",*string,*width);
}

- (void)testIvarList{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([NSObject class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSObject *value = [[NSObject new] valueForKey:[NSString stringWithUTF8String:name]];
        NSLog(@"%@",value);
    }
}

//测试指针的变换
- (void)testPointer{
    int arrayName[4] = {10,20,30,40};
    int *p = (int *)(&arrayName + 1);

    NSLog(@"%d",*(p - 1));
    NSLog(@"%p===%p",&arrayName,&arrayName + 1);

    NSLog(@"%p----%d++++++%d",p - 1,*(p - 1),*p);
}

- (void)textconvertRect{
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    [self.view addSubview:red];
    red.backgroundColor = [UIColor redColor];
    
    UIView *blue = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    [red addSubview:blue];
    blue.backgroundColor = [UIColor blueColor];
    
    CGRect rect = [red convertRect:blue.frame toView:self.view];
    NSLog(@"%@",NSStringFromCGRect(rect));
}

- (void)nsurlsessonTest{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@""]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)createCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat item_w = ([UIScreen mainScreen].bounds.size.width - 25) / 4;
    layout.itemSize = CGSizeMake(item_w, item_w);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, item_w * 2 + 15) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    [collection registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    self.collectionView = collection;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.photoArray.count == 8) {
        return self.photoArray.count;
    }else{
        return self.photoArray.count + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    if (indexPath.item < self.photoArray.count) {
        cell.assetModel = self.photoArray[indexPath.item];
    }else{
        cell.assetModel = nil;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.photoArray.count == indexPath.item) {
        AssetViewController *assetVC = [[AssetViewController alloc] init];
        assetVC.selectImage = ^(NSArray *imageArray) {
            self.photoArray = imageArray;
            [self.collectionView reloadData];
        };
        if (self.photoArray.count) {
            assetVC.selectImages = self.photoArray;
        }
        [self presentViewController:assetVC animated:YES completion:nil];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
