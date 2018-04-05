//
//  SortAlgorithm.h
//  TestDemo
//
//  Created by Jack on 2018/3/27.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortAlgorithm : NSObject


/**
 快速排序

 @param dataArray 排序数组
 @param leftIndex 指向数组的第一个元素
 @param rightIndex 指向数组的最后一个元素
 */
- (NSArray *)quickSortArray:(NSArray *)dataArray withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex;

@end
