//
//  ItemCell.h
//  TestDemo
//
//  Created by Jack on 2018/1/29.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssetModel;
@interface ItemCell : UICollectionViewCell

/** 图片数据 */
@property (strong, nonatomic) AssetModel *assetModel;

@end
