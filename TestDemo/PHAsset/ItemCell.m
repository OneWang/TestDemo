//
//  ItemCell.m
//  TestDemo
//
//  Created by Jack on 2018/1/29.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ItemCell.h"
#import "AssetModel.h"
#import "AssetImageManager.h"

@interface ItemCell ()

/** 照片 */
@property (weak, nonatomic) UIImageView *photoView;
/** 删除按钮 */
@property (weak, nonatomic) UIButton *deleteButton;

@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *photo = [[UIImageView alloc] init];
        [self.contentView addSubview:photo];
        self.photoView = photo;
        photo.image = [UIImage imageNamed:@"AlbumAddBtn"];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.clipsToBounds = YES;

        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:delete];
        self.deleteButton = delete;
        [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)deleteClick:(UIButton *)button{
    if (self.callBack) {
        self.callBack(self.assetModel);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.photoView.frame = self.bounds;
    self.deleteButton.frame = CGRectMake(self.bounds.size.width - 35, 0, 35, 35);
}

- (void)setAssetModel:(AssetModel *)assetModel{
    _assetModel = assetModel;
    
    if (assetModel) {
        [[AssetImageManager shardInstance] getPhotoWithAsset:assetModel.asset photoSize:CGSizeMake(200, 200) completion:^(UIImage *photo, NSDictionary *info) {
            self.photoView.image = photo;
        }];
        _deleteButton.hidden = NO;
    }else{
        _deleteButton.hidden = YES;
        self.photoView.image = [UIImage imageNamed:@"AlbumAddBtn"];
    }
}

@end
