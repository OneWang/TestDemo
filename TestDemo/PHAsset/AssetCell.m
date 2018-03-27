//
//  AssetCell.m
//  TestDemo
//
//  Created by Jack on 2018/1/24.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "AssetCell.h"
#import <Photos/Photos.h>
#import "AssetModel.h"
#import "AssetImageManager.h"

NSString *const AssetLoadFinishImageNotifcation = @"AssetLoadFinishImageNotifcation";

@interface AssetCell ()
/** 显示图片 */
@property (weak, nonatomic) UIImageView *imageView;
/** 选择按钮 */
@property (weak, nonatomic) UIButton *checkButton;
@end

@implementation AssetCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        self.imageView = imageView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:button];
        self.checkButton = button;
        [button setImage:[UIImage imageNamed:@"photo_def_photoPickerVc"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonCick:) forControlEvents:UIControlEventTouchUpInside];        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    // 选择按钮右上角 35 * 35
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat checkWH = 35;
    CGFloat checkY = 0;
    CGFloat checkX = width - checkWH;
    self.checkButton.frame = CGRectMake(checkX, checkY, checkWH, checkWH);
}

- (void)buttonCick:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetCell:didClickButton:)]) {
        [self.delegate assetCell:self didClickButton:button];
    }
}

- (void)setAssetModel:(AssetModel *)assetModel{
    _assetModel = assetModel;
    
    self.checkButton.selected = assetModel.selected;
    
    [[AssetImageManager shardInstance] getPhotoWithAsset:assetModel.asset photoSize:CGSizeMake(200, 200) completion:^(UIImage *photo, NSDictionary *info) {
        self.imageView.image = photo;
    }];
//    if (imageRequestID) {
//        [[PHImageManager defaultManager] cancelImageRequest:imageRequestID];
//    }
}

@end
