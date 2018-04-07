//
//  AssetModel.m
//  TestDemo
//
//  Created by Jack on 2018/1/25.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AssetModel.h"
#import "AssetImageManager.h"

@implementation AssetModel

+ (instancetype)modelWithAsset:(id)asset{
    AssetModel *model = [[AssetModel alloc] init];
    model.asset = asset;
    model.selected = NO;
    return model;
}

@end

@implementation AlbumModel

- (void)setResult:(id)result{
    _result = result;
    
    __weak typeof(self)weakSelf = self;
    //获取照片数组
    [[AssetImageManager shardInstance] getAlumbAssetFetchResult:result completion:^(NSArray<AssetModel *> *models) {
        weakSelf.models = models;
    }];
}

@end
