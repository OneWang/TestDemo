//
//  MainModel.h
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
/** name */
@property (copy, nonatomic) NSString *name;
/** 目标 */
@property (copy, nonatomic) Class destationVC;
@end
