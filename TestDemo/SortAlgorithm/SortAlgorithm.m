//
//  SortAlgorithm.m
//  TestDemo
//
//  Created by Jack on 2018/3/27.
//  Copyright © 2018年 Jack. All rights reserved.
//  八大排序算法

#import "SortAlgorithm.h"

@implementation SortAlgorithm

- (instancetype)init{
    if (self = [super init]) {
        quickSort([NSMutableArray arrayWithArray:@[@12,@2,@23,@3,@45,@12,@9,@140]], 0, 7);
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

/**
 快速排序
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据比另一部分的所有数据都小；
 简单的理解就是：在数组中找一个支点（任意），经过一趟排序后，支点左边的数要比支点小，支点右边的数据要比支点大；
 @[@12,@2,@23,@3,@45,@12,@9,@140]
 */
- (NSArray *)quickSortArray:(NSMutableArray *)dataArray withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex{
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //首先定一个支点
    NSInteger pivot = [dataArray[(leftIndex + rightIndex) / 2] integerValue];
    //左右两端进行扫描，只要两端还没有交换就一直进行扫描
    while (i <= j) {
        //在左边寻找比支点大的数
        while (pivot > [dataArray[i] integerValue]) {
            i ++;
        }
        
        //在右边寻找比支点小的数据
        while (pivot < [dataArray[j] integerValue]) {
            j --;
        }
        
        //此时找到分别找到左边比支点大的数，右边比支点小的数据；开始进行交换
        if (i <= j) {
            id temp = dataArray[i];
            dataArray[i] = dataArray[j];
            dataArray[j] = temp;
            i ++;
            j --;
        }
    }
    //上面的保证支点的左边都比支点小，支点的右边都比支点大
    
    if (leftIndex < j) {
        [self quickSortArray:dataArray withLeftIndex:leftIndex andRightIndex:j];
    }
    
    if (i < rightIndex) {
        [self quickSortArray:dataArray withLeftIndex:i andRightIndex:rightIndex];
    }
    NSLog(@"方法：%@",dataArray);
    return dataArray;
}

/**
 * 快速排序
 * @param L   指向数组第一个元素
 * @param R   指向数组最后一个元素
 */
void quickSort(NSMutableArray *arr, int L, int R) {
    int i = L;
    int j = R;
    //支点
    int pivot = [arr[(L + R) / 2] intValue];
    //左右两端进行扫描，只要两端还没有交替，就一直扫描
    while (i <= j) {
        //寻找直到比支点大的数
        while (pivot > [arr[i] intValue])
            i++;
        //寻找直到比支点小的数
        while (pivot < [arr[j] intValue])
            j--;
        //此时已经分别找到了比支点小的数(右边)、比支点大的数(左边)，它们进行交换
        if (i <= j) {
            id temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            i++;
            j--;
        }
    }
    //上面一个while保证了第一趟排序支点的左边比支点小，支点的右边比支点大了。
    //“左边”再做排序，直到左边剩下一个数(递归出口)
    if (L < j)
        quickSort(arr, L, j);
    //“右边”再做排序，直到右边剩下一个数(递归出口)
    if (i < R)
        quickSort(arr, i, R);
    
    NSLog(@"函数%@",arr);
}

/**
 归并排序
 */

@end
