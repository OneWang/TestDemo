//
//  ImageCell.h
//  TestDemo
//
//  Created by Jack on 2018/5/14.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageModel;
@interface ImageCell : UITableViewCell
/** 图片模型 */
@property (strong, nonatomic) ImageModel *model;
@property (copy, nonatomic) NSString *imageName;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
