//
//  DownloadImage.h
//  TestDemo
//
//  Created by Jack on 2018/5/18.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadImage : NSObject
/** 图片名字 */
@property (copy, nonatomic) NSString *name;
/** 图片路径 */
@property (copy, nonatomic) NSString *icon;
/** 图片下载量 */
@property (copy, nonatomic) NSString *download;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
