//
//  Invoker.h
//  Method_Nature_Demo
//
//  Created by Jack on 2019/6/6.
//  Copyright © 2019 Jack. All rights reserved.
//

#ifndef Invoker_h
#define Invoker_h

#import <Foundation/Foundation.h>

@protocol Invoker <NSObject>

@required
// 在调用对象中的方法前执行对功能的横切
- (void)preInvoke:(NSInvocation *)inv withTarget:(id)target;
@optional
// 在调用对象中的方法后执行对功能的横切
- (void)postInvoke:(NSInvocation *)inv withTarget:(id)target;

@end

#endif /* Invoker_h */
