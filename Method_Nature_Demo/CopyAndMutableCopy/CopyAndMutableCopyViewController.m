//
//  CopyAndMutableCopyViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/22.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "CopyAndMutableCopyViewController.h"
#import "Dog.h"

@interface CopyAndMutableCopyViewController ()
@property (strong, nonatomic) NSMutableArray<Dog *> *data1Array;
@property (strong, nonatomic) NSMutableArray<Dog *> *data2Array;
@end

@implementation CopyAndMutableCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 10; i ++) {
        Dog *dog1 = [[Dog alloc] init];
        dog1.name = [NSString stringWithFormat:@"姓名：%d",i];
        dog1.nick = [NSString stringWithFormat:@"外号：%d",i];
        dog1.age = i + 100;
        [self.data1Array addObject:dog1];
    }
    self.data2Array = [self.data1Array copy];
    
    self.data1Array.firstObject.name = @"汪汪汪";
    self.data1Array.firstObject.age = 1000;
    
    /**
     总结：对于不可变的集合类对象进行 copy 操作，只是改变了指针，其内存地址并没有发生变化；进行 mutableCopy 操作，内存地址发生了变化，但是其中的元素内存地址并没有发生变化。
     对于可变集合类对象，不管是进行 copy 操作还是 mutableCopy 操作，其内存地址都发生了变化，但是其中的元素内存地址都没有发生变化，属于单层深拷贝。
     要实现深拷贝就必须让集合中的对象遵循NSCopying协议这样才能实现深层拷贝
     */
}

- (NSMutableArray<Dog *> *)data1Array{
    if (!_data1Array) {
        _data1Array = [NSMutableArray array];
    }
    return _data1Array;
}

@end
