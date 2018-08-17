//
//  Stuff.h
//  TestDemo
//
//  Created by Jack on 2018/4/8.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
/** 动物名字 */
@property (copy, nonatomic) NSString *animalName;
/** 动物年龄 */
@property (assign, nonatomic) NSUInteger animalAge;
@end

@interface Stuff : NSObject
/** 名字 */
@property (copy, nonatomic) NSString *name;
/** 年龄 */
@property (assign, nonatomic) NSUInteger age;
/** 年级 */
@property (copy, nonatomic) NSString *grade;
/** 动物 */
@property (strong, nonatomic) Animal *animal;
@end
