//
//  MLURLSessionWrapperOperation.h
//  Method_Nature_Demo
//
//  Created by Jack on 2018/11/12.
//  Copyright © 2018 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLURLSessionWrapperOperation : NSOperation

+ (instancetype)operationWithURLSessionTask:(NSURLSessionTask *)task;

@end

NS_ASSUME_NONNULL_END
