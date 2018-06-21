//
//  CollectionViewController.m
//  TestDemo
//
//  Created by Jack on 2018/6/21.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDictionary *dict1 = [[NSDictionary alloc] init];
    NSDictionary *dict2 = @{};
    NSDictionary *dict3 = [dict copy];
    NSDictionary *dict4 = [dict mutableCopy];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];
    NSDictionary *dict6 = [dict5 copy];
    NSDictionary *dict7 = [dict6 mutableCopy];
    NSDictionary *dict8 = [NSDictionary dictionary];
    NSLog(@"%s===%s===%s===%s===%s===%s===%s===%s",object_getClassName(dict),object_getClassName(dict1),object_getClassName(dict2),object_getClassName(dict3),object_getClassName(dict4),object_getClassName(dict5),object_getClassName(dict7),object_getClassName(dict8));
    //__NSDictionaryM===__NSDictionary0===__NSDictionary0===__NSFrozenDictionaryM===__NSDictionaryM===__NSDictionaryI===__NSDictionaryM===__NSDictionary0
}

@end
