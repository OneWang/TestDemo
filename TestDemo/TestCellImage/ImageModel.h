//
//  ImageModel.h
//  TestDemo
//
//  Created by Jack on 2018/5/14.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *price;
@end
