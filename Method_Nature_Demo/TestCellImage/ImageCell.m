//
//  ImageCell.m
//  TestDemo
//
//  Created by Jack on 2018/5/14.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ImageCell.h"
#import <Masonry.h>
#import "ImageModel.h"

@interface ImageCell ()
/** 图片 */
@property (weak, nonatomic) UIImageView *iconView;
@end

@implementation ImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.iconView = image;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(@100);
        }];
    }
    return self;
}

- (void)setModel:(ImageModel *)model{
    _model = model;
    _iconView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]]];
    self.textLabel.text = model.price;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    _iconView.image = [UIImage imageNamed:imageName];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifer = @"ImageCell";
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        NSLog(@"创建 cell:%@",cell);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
