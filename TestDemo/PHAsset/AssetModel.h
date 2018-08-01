//
//  AssetModel.h
//  TestDemo
//
//  Created by Jack on 2018/1/25.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AssetModel : NSObject

/** 资源 */
@property (strong, nonatomic) id asset;
/** 在 cell 表示是否选中 */
@property (assign, nonatomic, getter=isSelected) BOOL selected;

/** 初始化方法 */
+ (instancetype)modelWithAsset:(id)asset;

@end

@interface AlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@property (nonatomic, strong) NSArray<AssetModel *> *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;

@property (nonatomic, assign) BOOL isCameraRoll;

@end
