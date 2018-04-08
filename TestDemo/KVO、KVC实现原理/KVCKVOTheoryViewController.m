//
//  KVCKVOTheoryViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/8.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "KVCKVOTheoryViewController.h"
#import "Stuff.h"

@interface KVCKVOTheoryViewController ()

@end

@implementation KVCKVOTheoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    Animal *model = [[Animal alloc] init];
    model.animalName = @"cat";
    [model setValue:@"dog" forKey:@"animalName"];   //通过set方法访问
    [model setValue:@"monkey" forKey:@"_animalName"];   //直接访问实例变量
    [model setValue:@"123" forKey:@"name"];
    NSLog(@" setter name %@",model.animalName);
    
    Stuff *person = [[Stuff alloc] init];
    person.animal = model;
    [person setValue:@"123321" forKeyPath:@"animal.animalName"]; //通过set方法访问
    [person setValue:@"jack" forKeyPath:@"animal._animalName"];     //直接访问实例变量
    NSLog(@"%@",person.animal.animalName);
    
    Stuff *stuff1 = [[Stuff alloc] init];
    stuff1.name = @"1";
    Stuff *stuff2 = [[Stuff alloc] init];
    stuff2.name = @"1";
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:stuff1];
    [set addObject:stuff2];
    NSLog(@"%ld===%d",set.count,[stuff1 isEqual:stuff2]);
}

@end
