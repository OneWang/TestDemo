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
/** 动物 */
@property (strong, nonatomic) Animal *model;
@end

@implementation KVCKVOTheoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    Animal *model = [[Animal alloc] init];
    model.animalName = @"old";
    self.model = model;
    [model addObserver:self forKeyPath:@"animalName" options:NSKeyValueObservingOptionOld context:nil];
    [model addObserver:self forKeyPath:@"animalAge" options:NSKeyValueObservingOptionOld context:nil];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"animalName"]) {
        NSLog(@"%@=======%@",object,[change valueForKey:NSKeyValueChangeOldKey]);
    }
}

- (void)dealloc{
    NSLog(@"%@",self.model.observationInfo);
    id info = self.model.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        NSLog(@"--------%@",keyPath);
    }
    //1.解决多次移出观察者
    @try {
        [self.model removeObserver:self forKeyPath:@"animalName" context:nil];
    } @catch (NSException *exception) {
        NSLog(@"多次删除观察者%@",exception);
    } @finally {
        NSLog(@"默认返回这");
    }
    NSLog(@"%s",__func__);
}
/**
 解决观察者模式中观察者被移出多次导致crash的问题的解决方案：
 1.利用@try @catch @finally；（直接使用，或者给NSObject添加分类交换方法的实现）只能针对解决删除多次KVO的情况
 2.利用模型数组进行存储；第一步：利用runtime的黑魔法交换方法来实现监听的对象和对应的属性；第二步：用一个对象将监听的对象和属性存储起来，然后添加到数组中；第三步：在存储之前检验是否多次添加KVO，便利数组中的对象和属性是否一致；同样对于删除KVO也是一样，检验是否多次移出；
 3.
 第一步 简单介绍下observationInfo属性
 1，只要是继承与NSObject的对象都有observationInfo属性.
 2，observationInfo是系统通过分类给NSObject增加的属性。
 3，分类文件是NSKeyValueObserving.h这个文件
 4，这个属性中存储有属性的监听者，通知者，还有监听的keyPath，等等KVO相关的属性。
 5，observationInfo是一个void指针，指向一个包含所有观察者的一个标识信息对象，信息包含了每个监听的观察者,注册时设定的选项等。
 
 6，observationInfo结构 (箭头所指是我们等下需要用到的地方)
 
 第二步 实现方案思路
 1，通过私有属性直接拿到当前对象所监听的keyPath
 
 2，判断keyPath有或者无来实现防止多次重复添加和删除KVO监听。
 
 3，通过Dump Foundation.framework 的头文件，和直接xcode查看observationInfo的结构，发现有一个数组用来存储NSKeyValueObservance对象，经过测试和调试，发现这个数组存储的需要监听的对象中，监听了几个属性，如果监听两个，数组中就是2个对象。
 比如这是监听两个属性状态下的数组
 
 4，NSKeyValueObservance属性简单说明
 _observer属性：里面放的是监听属性的通知这，也就是当属性改变的时候让哪个对象执行observeValueForKeyPath的对象。
 _property 里面的NSKeyValueProperty NSKeyValueProperty存储的有keyPath,其他属性我们用不到，暂时就不说了。
 5，拿出keyPath
 这时候思路就有了，首先拿出_observances数组，然后遍历拿出里面_property对象里面的NSKeyValueProperty下的一个keyPath，然后进行判断需要删除或添加的keyPath是否一致，然后分别进行处理就行了。
 */

@end
