//
//  AuditingInvoker.m
//  Method_Nature_Demo
//
//  Created by Jack on 2019/6/6.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "AuditingInvoker.h"

@implementation AuditingInvoker

- (void)preInvoke:(NSInvocation *)inv withTarget:(id)target{
    NSLog(@"before sending message with selector %@ to %@ object", NSStringFromSelector([inv selector]),[target class]);
}
- (void)postInvoke:(NSInvocation *)inv withTarget:(id)target{
    NSLog(@"after sending message with selector %@ to %@ object", NSStringFromSelector([inv selector]),[target class]);
}

@end
