//
//  PreviewView.h
//  TestDemo
//
//  Created by Jack on 2018/8/2.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AssetModel;
@interface PreviewView : UIView
/** 数据源数组 */
@property (nonatomic, strong) NSArray *dataArray;
/** 索引值 */
@property (nonatomic, assign) NSInteger index;
@end
