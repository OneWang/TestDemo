//
//  AssetImageManager.h
//  TestDemo
//
//  Created by Jack on 2018/1/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AssetModel,AlbumModel;
@interface AssetImageManager : NSObject

+ (instancetype)shardInstance;

- (void)getPhotoLibraryOriginal:(BOOL)original completion:(void(^)(AlbumModel *))completion;

- (int32_t)getPhotoWithAsset:(id)asset photoSize:(CGSize)size completion:(void(^)(UIImage *photo,NSDictionary *info))completion;

- (void)getAlumbAssetFetchResult:(id)result completion:(void(^)(NSArray<AssetModel *> *))completion;

@end
