//
//  BHPrivateSubView.m
//  BHPrivatePod
//
//  Created by Jack on 2018/12/29.
//

#import "BHPrivateSubView.h"

@implementation BHPrivateSubView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[UIView alloc] initWithFrame:frame];
        [self addSubview:view];
        view.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
