//
//  PreviewView.m
//  TestDemo
//
//  Created by Jack on 2018/8/2.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "PreviewView.h"
#import "AssetModel.h"
#import "AssetImageManager.h"

@interface PreviewViewCell : UICollectionViewCell
/** 照片 */
@property (nonatomic, strong) AssetModel *imageModel;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation PreviewViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.frame = UIScreen.mainScreen.bounds;
        imageView.contentMode = UIViewContentModeCenter;
        _imageView = imageView;
    }
    return self;
}

- (void)setImageModel:(AssetModel *)imageModel{
    [[AssetImageManager shardInstance] getPhotoWithAsset:imageModel.asset photoSize:UIScreen.mainScreen.bounds.size completion:^(UIImage *photo, NSDictionary *info) {
        self.imageView.image = photo;
    }];
}

@end

@interface PreviewView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation PreviewView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = UIScreen.mainScreen.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[PreviewViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PreviewViewCell class])];
        _collectionView.contentOffset = CGPointMake(frame.size.width * _index, 0);
        _collectionView.pagingEnabled = YES;
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PreviewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PreviewViewCell" forIndexPath:indexPath];
    cell.imageModel = _dataArray[indexPath.row];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [_collectionView reloadData];
}

@end
