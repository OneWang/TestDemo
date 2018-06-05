//
//  AlgorithmViewController.m
//  TestDemo
//
//  Created by Jack on 2018/6/4.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AlgorithmViewController.h"

@interface AlgorithmViewController ()

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[self revertWithString:@"asdf"]);
}

//判断一个数是否为素数
- (BOOL)isPrimeNumber:(NSInteger)number{
    if (number < 2) return NO;
    for (int i = 2; i <= (NSInteger)sqrt(number); i ++) {
        if (number % i == 0) {
            return NO;
        }
    }
    return YES;
}

//获取指定范围内素数的个数
- (NSInteger)getPrimeNumberFrom:(NSInteger)from to:(NSInteger)to{
    NSInteger count = 0;
    for (; from <= to; from ++) {
        if ([self isPrimeNumber:from]) {
            count ++;
        }
    }
    return count;
}

//判断一个数是否是2的幂
- (BOOL)isTwoPower:(NSInteger)number{
    if (number > 0 && (number & (number - 1)) == 0) {
        return YES;
    }else{
        return NO;
    }
}

//给定一个整数数组和一个目标值，找出数组中和为目标值的两个数。
- (NSArray *)twoSum:(NSArray *)array target:(NSInteger)target{
    for (int i = 0; i < array.count; i ++) {
        for (int j = i + 1; j < array.count; j ++) {
            if ([array[j] integerValue] == target - [array[i] integerValue]) {
                return @[@(i),@(j)];
            }
        }
    }
    return @[];
}

//判断是否是回文数字（不通过字符串反转，只反转一半数字）
- (BOOL)isPlalindromeNumber:(NSInteger)number{
    if (number < 0 || (number % 10 == 0 && number != 0)) {
        return NO;
    }
    NSInteger revertedNumber = 0;
    //当原始数小于反转的数说明反转过半（处理一半位数的数字）
    while (number > revertedNumber) {
        revertedNumber = revertedNumber * 10 + number % 10;
        number /= 10;
    }
    // 当数字长度为奇数时，我们可以通过 revertedNumber/10 去除处于中位的数字。
    // 例如，当输入为 12321 时，在 while 循环的末尾我们可以得到 x = 12，revertedNumber = 123，
    // 由于处于中位的数字不影响回文（它总是与自己相等），所以我们可以简单地将其去除。
    return number == revertedNumber || number == revertedNumber / 10;
}

//算法逆序输出字符串
- (NSString *)revertWithString:(NSString *)string{
    if (string == nil || string.length == 0) {
        return string;
    }
    if (string.length == 1) {
        return string;
    }else{
        string = [self revertWithString:[string substringWithRange:NSMakeRange(1, string.length - 1)]];
        return [NSString stringWithFormat:@"%@%@",string,[string substringToIndex:1]];
    }
}

@end
