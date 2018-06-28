//
//  BlockAndPointer.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BlockAndPointer.h"

@implementation BlockAndPointer

- (instancetype)init{
    if (self = [super init]) {
        self.name = @"jack";
    }
    return self;
}

#pragma mark - block作为参数和返回值的使用
- (void)testFunction{
    [self setUpTitleEffect:^(NSString *__autoreleasing *title, CGFloat *width) {
        *title = @"我是指针的指针";
        *width = 12.5;
    }];
    
    NSString *string = @"单独的指针";
    CGFloat count = 109043.f;
    [self setupTitleWithSting:&string andWidth:&count];
}

- (void)testBlock{
    void(^testblock)(int n) = [self createFunctionWithString:^NSString *(NSArray *numarray) {
        NSMutableString *string = [NSMutableString string];
        for (NSString *str in numarray) {
            NSLog(@"%@",str);
            [string appendString:str];
        }
        return string;
    }];
    if (testblock) {
        testblock(8);
    }
}

- (void(^)(int number))createFunctionWithString:(NSString *(^)(NSArray *))stringBlock{
    if (stringBlock) {
        NSLog(@"%@",stringBlock(@[@"d",@"d"]));
    }
    return ^(int num){
        if (stringBlock) {
            NSLog(@"%@",stringBlock(@[@"嗯我若无",@"发生的",@"fas"]));
        }
    };
}

#pragma mark - 使用指向指针的指针进行传值
- (void)setUpTitleEffect:(void(^)(NSString **title,CGFloat *width))titleEffectBlock{
    NSString *title;
    CGFloat width;
    if (titleEffectBlock) {
        titleEffectBlock(&title,&width);
        NSLog(@"%@===%f",title,width);
    }
}

- (void)setupTitleWithSting:(NSString **)string andWidth:(CGFloat *)width{
    NSLog(@"%@=====%f",*string,*width);
}

@end
