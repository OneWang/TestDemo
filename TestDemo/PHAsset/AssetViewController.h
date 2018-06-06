//
//  AssetViewController.h
//  TestDemo
//
//  Created by Jack on 2018/1/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AssetModel;
@interface AssetViewController : UIViewController
/** 选择之后回调的照片 */
@property (copy, nonatomic) void(^selectImage)(NSArray *imageArray);
/** 选中的照片 */
@property (strong, nonatomic) NSArray<AssetModel *> *selectImages;
@end
