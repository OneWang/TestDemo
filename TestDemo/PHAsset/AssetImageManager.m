//
//  AssetImageManager.m
//  TestDemo
//
//  Created by Jack on 2018/1/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AssetImageManager.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetModel.h"
#import <UIKit/UIKit.h>

@implementation AssetImageManager

+ (instancetype)shardInstance{
    static AssetImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AssetImageManager alloc] init];
    });
    return manager;
}

//获取相册中的相册数据
- (void)getPhotoLibraryOriginal:(BOOL)original completion:(void(^)(AlbumModel *))completion{
    //获取当前应用的使用权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return ;     //用户未授权使用相册
        //获取默认相册图片
        PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (PHAssetCollection *collection in smartAlbums) {
            // 有可能是PHCollectionList类的的对象，过滤掉
            if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
            if ([self isCameraRollAlbum:collection]) {
                PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
                if ([fetchResult isKindOfClass:[PHFetchResult class]]) {
                    PHFetchResult *result = (PHFetchResult *)fetchResult;
                    AlbumModel *model = [[AlbumModel alloc] init];
                    model.result = result;
                    model.isCameraRoll = NO;
                    if (completion) { completion(model); }
                    break;
                }
            }
        }
    }];
}

- (BOOL)isCameraRollAlbum:(id)metadata {
    if ([metadata isKindOfClass:[PHAssetCollection class]]) {
        NSString *versionStr = [[UIDevice currentDevice].systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
        if (versionStr.length <= 1) {
            versionStr = [versionStr stringByAppendingString:@"00"];
        } else if (versionStr.length <= 2) {
            versionStr = [versionStr stringByAppendingString:@"0"];
        }
        CGFloat version = versionStr.floatValue;
        // 目前已知8.0.0 ~ 8.0.2系统，拍照后的图片会保存在最近添加中
        if (version >= 800 && version <= 802) {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumRecentlyAdded;
        } else {
            return ((PHAssetCollection *)metadata).assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary;
        }
    }
    return NO;
}

//获得照片数组
- (void)getAlumbAssetFetchResult:(id)result completion:(void(^)(NSArray<AssetModel *> *))completion{
    NSMutableArray *photoArr = [NSMutableArray array];
    if ([result isKindOfClass:[PHFetchResult class]]) {
        PHFetchResult *fetchResult = (PHFetchResult *)result;
        [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AssetModel *model;
            if ([obj isKindOfClass:[PHAsset class]]) {
                model = [AssetModel modelWithAsset:obj];
            }
            if (model) {
                [photoArr addObject:model];
            }
        }];
        if (completion) completion(photoArr);
    }
}

//获取照片本身
- (int32_t)getPhotoWithAsset:(id)asset photoSize:(CGSize)size completion:(void(^)(UIImage *photo,NSDictionary *info))completion{
    if ([asset isKindOfClass:[PHAsset class]]) {
        __block UIImage *image;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = false;  //true为同步获取图片,比较耗时;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;     //图片的缩放模式
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;     //图片的显示质量模式
        options.networkAccessAllowed = NO;
        int32_t imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            if (result) {
                image = result;
            }
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined && result) {
                if (completion) completion(result,info);
            }
        }];
        return imageRequestID;
    }
    return 0;
}

@end
