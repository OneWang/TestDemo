//
//  MultiThreads.m
//  TestDemo
//
//  Created by Jack on 2018/4/5.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "MultiThreads.h"

@implementation MultiThreads

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)testGCD{
    //并发队列同步派发任务
    dispatch_queue_t my_queue2 = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_sync(my_queue2, ^{ // block 1
            sleep(2);
            NSLog(@"1-%@", [NSThread currentThread]);
        });
    });
    sleep(0.5);
    dispatch_sync(my_queue2, ^{ // block 2
        dispatch_async(my_queue2, ^{ // block 3
            NSLog(@"2-%@", [NSThread currentThread]);
        });
        sleep(1);
        NSLog(@"3-%@", [NSThread currentThread]);
    });
    NSLog(@"4-%@", [NSThread currentThread]);
//串行队列同步派发任务
//    dispatch_queue_t serial = dispatch_queue_create("串行", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(serial, ^{
//        NSLog(@"3%@",[NSThread currentThread]);
//    });
//    dispatch_sync(serial, ^{
//        NSLog(@"4%@",[NSThread currentThread]);
//    });
}

- (void)testGCDBarrier{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //读操作
        NSLog(@"读操作--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        // 读操作
        NSLog(@"读操作--%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        // 写操作
        NSLog(@"写操作--%@",[NSThread currentThread]);
        sleep(2);
    });
    dispatch_barrier_sync(queue, ^{
        // 写操作
        NSLog(@"写操作--%@",[NSThread currentThread]);
        sleep(3);
    });
    dispatch_async(queue, ^{
        // 读操作
        NSLog(@"读操作--%@",[NSThread currentThread]);
    });
    
    //阻塞并行队列
    dispatch_barrier_sync(queue, ^{
        dispatch_async(queue, ^{
            NSLog(@"任务二");
        });
        dispatch_async(queue, ^{
            NSLog(@"任务三");
        });
        //睡眠2秒
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务一");
    });
    
    dispatch_sync(queue, ^{
        //不能阻塞并发队列
        dispatch_async(queue, ^{
            NSLog(@"任务二");
        });
        dispatch_async(queue, ^{
            NSLog(@"任务三");
        });
        //睡眠2秒
        [NSThread sleepForTimeInterval:2];
        NSLog(@"任务一");
    });
}

- (void)testGCDSemaphore{
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建信号量，并且设置值为10
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++){
        // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10次后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i===%@",i,[NSThread currentThread]);
            sleep(2);
            // 每次发送信号则semaphore会+1，
            dispatch_semaphore_signal(semaphore);
        });
    }
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 10; i ++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%d===%@",i,[NSThread currentThread]);
//            sleep(3);
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            [array addObject:@(i)];
//            NSLog(@"后%d===%@",i,[NSThread currentThread]);
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
}

@end
