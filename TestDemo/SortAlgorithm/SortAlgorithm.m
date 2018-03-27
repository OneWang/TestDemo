//
//  SortAlgorithm.m
//  TestDemo
//
//  Created by Jack on 2018/3/27.
//  Copyright © 2018年 Jack. All rights reserved.
//  排序算法

#import "SortAlgorithm.h"

@implementation SortAlgorithm

- (instancetype)init{
    if (self = [super init]) {
        [self testSort2];
    }
    return self;
}

/**
 冒泡排序
 思路：两两交换，大的放在后面，第一次排序后最大值已在数组末尾。因为两两交换，需要N-1趟排序；
 代码实现要点：
            两个for循环，外层循环控制排序的趟数，内层循环控制比较的次数
            每趟过后，比较的次数都应该要减1
 优化：如果一趟排序后也没有交换位置，那么该数组已有序～
 */
- (void)testSort1{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1,@2,@4,@5,@1,@2,@3,@4]];
    for (int i = 0; i < array.count - 1; i ++) {
        for (int j = 0; j < array.count - 1 - i; j ++) {
            if (array[j] > array[j + 1]) {
                NSNumber *temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
    NSLog(@"%@",array);
}

/**
 选择排序
 思路：找到数组中最大的元素，与数组最后一位元素交换，当只有一个数时，则不需要选择了，因此需要N-1趟排序；
 代码实现要点：
            两个for循环，外层循环控制排序的趟数，内层循环找到当前趟数的最大值，随后与当前趟数组最后的一位元素交换；
 */
- (void)testSort2{
    NSMutableArray *arrays = [NSMutableArray arrayWithArray:@[@12,@32,@1,@35,@67,@14]];
    //外层循环控制需要排序的趟数
    for (int i = 0; i < arrays.count - 1; i++) {
        //新的趟数、将角标重新赋值为0
        int pos = 0;
        //内层循环控制遍历数组的个数并得到最大数的角标
        for (int j = 0; j < arrays.count - i; j++) {
            if (arrays[j] > arrays[pos]) {
                pos = j;
            }
        }
        //交换
        NSNumber *temp = arrays[pos];
        arrays[pos] = arrays[arrays.count - 1 - i];
        arrays[arrays.count - 1 - i] = temp;
    }
    NSLog(@"%@",arrays);
}

@end
