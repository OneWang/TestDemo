//
//  Stuff.m
//  TestDemo
//
//  Created by Jack on 2018/4/8.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "Stuff.h"

@implementation Animal
- (void)setAnimalName:(NSString *)animalName{
    _animalName = animalName;
    NSLog(@"执行 setter _animalName");
}

- (void)setName:(NSString *)name{
    NSLog(@"执行 setter name");
}

@end

@implementation Stuff

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if (![self isKindOfClass:[self class]]) {
        return NO;
    }
    return [self isEqualStuff:(Stuff *)object];
}

- (BOOL)isEqualStuff:(Stuff *)stuff{
    if (!stuff) {
        return NO;
    }
    BOOL isEqualName = (!self.name && !stuff.name) || [self.name isEqualToString:stuff.name];
    BOOL isEqualAge = self.age == stuff.age;
    BOOL isEqualModel = (!self.animal && !stuff.animal) || [self.animal isEqual:stuff.animal];
    return isEqualName && isEqualAge && isEqualModel;
}

- (NSUInteger)hash{
    NSLog(@"---------%s",__func__);
    return [super hash];
}

@end
