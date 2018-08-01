//
//  ItemCell.h
//  TestDemo
//
//  Created by Jack on 2018/1/29.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssetModel;
typedef void(^deleteBlock)(AssetModel *model);

@interface ItemCell : UICollectionViewCell

/** 图片数据 */
@property (strong, nonatomic) AssetModel *assetModel;
/** 删除照片的回掉 */
@property (copy, nonatomic) deleteBlock callBack;

@end
