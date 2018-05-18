//
//  DownloadImage.m
//  TestDemo
//
//  Created by Jack on 2018/5/18.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "DownloadImage.h"

@implementation DownloadImage
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    DownloadImage *image = [[DownloadImage alloc] init];
    [image setValuesForKeysWithDictionary:dict];
    return image;
}
@end
