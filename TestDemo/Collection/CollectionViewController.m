//
//  CollectionViewController.m
//  TestDemo
//
//  Created by Jack on 2018/6/21.
//  Copyright © 2018年 Jack. All rights reserved.
//  类簇的子类

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property (copy, nonatomic) NSMutableArray *dataArray;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];   //0x60000042a7c0----__NSDictionaryM
    NSDictionary *dict1 = [[NSDictionary alloc] init];     //0x60000000a040----__NSDictionary0
    NSDictionary *dict2 = @{};      //0x60000000a040----__NSDictionary0
    NSDictionary *dict3 = [dict copy];      //0x60000042af20----__NSFrozenDictionaryM
    NSDictionary *dict4 = [dict mutableCopy];       //0x60000042bc80----__NSDictionaryM
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];   //0x60000046dbc0----__NSDictionaryI
    NSDictionary *dict6 = [dict5 copy];     //0x60000046dbc0----__NSDictionaryI
    NSDictionary *dict7 = [dict6 mutableCopy];  //0x60000042aec0----__NSDictionaryM
    NSDictionary *dict8 = [NSDictionary dictionary];    //0x60000000a040----__NSDictionary0
    NSLog(@"%s===%s===%s===%s===%s===%s===%s===%s",object_getClassName(dict),object_getClassName(dict1),object_getClassName(dict2),object_getClassName(dict3),object_getClassName(dict4),object_getClassName(dict5),object_getClassName(dict7),object_getClassName(dict8));
    //__NSDictionaryM===__NSDictionary0===__NSDictionary0===__NSFrozenDictionaryM===__NSDictionaryM===__NSDictionaryI===__NSDictionaryM===__NSDictionary0
    
    NSLog(@"%p---%p---%p---%p---%p---%p---%p---%p---%p",dict,dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8);
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    //copy之后转换为__NSArrayI是不可变数组，也就是没有removeObjectAtIndex:方法了
//    [self.dataArray removeObjectAtIndex:0];
    NSLog(@"%@",self.dataArray);
}

@end
