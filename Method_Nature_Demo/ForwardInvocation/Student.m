//
//  Student.m
//  Method_Nature_Demo
//
//  Created by Jack on 2019/6/6.
//  Copyright © 2019 Jack. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)study:(NSString *)subject :(NSString *)bookName{
    NSLog(@"Invorking method on %@ object with selector %@",[self class],NSStringFromSelector(_cmd));
}

- (void)study:(NSString *)subject andRead:(NSString *)bookName{
    NSLog(@"Invorking method on %@ object with selector %@",[self class],NSStringFromSelector(_cmd));
}

@end
