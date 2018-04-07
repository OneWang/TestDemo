//
//  ViewController.m
//  TestDemo
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "PhotoViewController.h"
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

@interface PhotoViewController ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionview */
@property (weak, nonatomic) UICollectionView *collectionView;
/** 照片数组 */
@property (strong, nonatomic) NSArray *photoArray;

@end

@implementation PhotoViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
