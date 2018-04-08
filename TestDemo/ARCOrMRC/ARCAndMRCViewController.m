//
//  ARCAndMRCViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ARCAndMRCViewController.h"

@interface ARCAndMRCViewController ()

@end

__weak NSString *string_weak = nil;
@implementation ARCAndMRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //场景1
    NSString *string = [NSString stringWithFormat:@"jackonewang"];
    string_weak = string;
    NSLog(@"%@==",string_weak);

    //场景2
//    @autoreleasepool{
//        NSString *string = [NSString stringWithFormat:@"jackonewang"];
//        string_weak = string;
//    }
//    NSLog(@"%@==",string_weak);
    
    //场景3
//    NSString *string1 = nil;
//    @autoreleasepool{
//        string1 = [NSString stringWithFormat:@"jackonewang"];
//        string_weak = string1;
//    }
//    NSLog(@"%@==",string_weak);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s----%@",__func__,string_weak);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s----%@",__func__,string_weak);
}

/**
 前提：我们都通过 [NSString stringWithFormat:@""] 创建了一个 autoreleased 对象，这是我们实验的前提。并且，为了能够在 viewWillAppear 和 viewDidAppear 中继续访问这个对象，我们使用了一个全局的 __weak 变量 string_weak 来指向它。因为 __weak 变量有一个特性就是它不会影响所指向对象的生命周期，这里我们正是利用了这个特性；
 场景一：当使用 [NSString stringWithFormat:@""] 创建一个对象时，这个对象的引用计数为 1 ，并且这个对象被系统自动添加到了当前的 autoreleasepool 中。当使用局部变量 string 指向这个对象时，这个对象的引用计数 +1 ，变成了 2 。因为在 ARC 下 NSString *string 本质上就是 __strong NSString *string 。所以在 viewDidLoad 方法返回前，这个对象是一直存在的，且引用计数为 2 。而当 viewDidLoad 方法返回时，局部变量 string 被回收，指向了 nil 。因此，其所指向对象的引用计数 -1 ，变成了 1 。
 
     而在 viewWillAppear 方法中，我们仍然可以打印出这个对象的值，说明这个对象并没有被释放。咦，这不科学吧？我读书少，你表骗我。不是一直都说当函数返回的时候，函数内部产生的对象就会被释放的吗？如果你这样想的话，那我只能说：骚年你太年经了。开个玩笑，我们继续。前面我们提到了，这个对象是一个 autoreleased 对象，autoreleased 对象是被添加到了当前最近的 autoreleasepool 中的，只有当这个 autoreleasepool 自身 drain 的时候，autoreleasepool 中的 autoreleased 对象才会被 release 。
 
     另外，我们注意到当在 viewDidAppear 中再打印这个对象的时候，对象的值变成了 nil ，说明此时对象已经被释放了。因此，我们可以大胆地猜测一下，这个对象一定是在 viewWillAppear 和 viewDidAppear 方法之间的某个时候被释放了，并且是由于它所在的 autoreleasepool 被 drain 的时候释放的。
 
     你说什么就是什么咯？有本事你就证明给我看你妈是你妈。额，这个我真证明不了，不过上面的猜测我还是可以证明的，不信，你看！
 
     在开始前，我先简单地说明一下原理，我们可以通过使用 lldb 的 watchpoint 命令来设置观察点，观察全局变量 string_weak_ 的值的变化，string_weak_ 变量保存的就是我们创建的 autoreleased 对象的地址。在这里，我们再次利用了 __weak 变量的另外一个特性，就是当它所指向的对象被释放时，__weak 变量的值会被置为 nil 。
 */

//测试两个字符串的初始化
- (void)testStringAddress{
    NSString *str1 = @"123";
    NSString *str2 = [NSString stringWithFormat:@"%@",@"123"];
    if (str1 == str2) {
        NSLog(@"as");
    }else{
        NSLog(@"sdf");
    }
}

@end
