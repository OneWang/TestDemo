//
//  AssetCell.h
//  TestDemo
//
//  Created by Jack on 2018/1/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssetModel,AssetCell;
@protocol AssetCellDelegate <NSObject>

- (void)assetCell:(AssetCell *)cell didClickButton:(UIButton *)button;

@end

@interface AssetCell : UICollectionViewCell

/** 代理 */
@property (weak, nonatomic) id<AssetCellDelegate> delegate;
/** 图片数据 */
@property (strong, nonatomic) AssetModel *assetModel;

@end
