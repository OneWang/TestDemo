//
//  Dog.m
//  TestDemo
//
//  Created by Jack on 2018/5/22.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "Dog.h"

@interface Dog ()<NSCopying>

@end

@implementation Dog

- (id)copyWithZone:(NSZone *)zone{
    Dog *dog = [[self class] allocWithZone:zone];
    //为每个属性创建新的空间，并将内容复制
    dog.name = [[NSString alloc] initWithString:self.name];
    dog.nick = [[NSString alloc] initWithString:self.nick];
    dog.age = self.age;
    return dog;
}

@end
