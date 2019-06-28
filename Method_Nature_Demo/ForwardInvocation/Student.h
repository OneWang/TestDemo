//
//  Student.h
//  Method_Nature_Demo
//
//  Created by Jack on 2019/6/6.
//  Copyright © 2019 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

- (void)study:(NSString *)subject andRead:(NSString *)bookName;
- (void)study:(NSString *)subject :(NSString *)bookName;

@end

NS_ASSUME_NONNULL_END
