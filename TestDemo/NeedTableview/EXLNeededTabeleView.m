//
//  EXLNeededTabeleView.m
//  ParentGet
//
//  Created by Jack on 2018/3/29.
//  Copyright © 2018年 Jack. All rights reserved.
//  按需加载的tableview

#import "EXLNeededTabeleView.h"

@interface EXLNeededTabeleView ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL scrollToToping;
}
/** 需要加载的数组 */
@property (strong, nonatomic) NSMutableArray *needLoadArray;
@end

@implementation EXLNeededTabeleView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"撒打算%zd",indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.needLoadArray removeAllObjects];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *firstIndexPath = [self indexPathsForVisibleRows].firstObject;
    NSInteger skipcount = 8;
    if (labs(firstIndexPath.row - indexPath.row) > skipcount) {
        NSArray *temp = [self indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.width, self.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y < 0) {//向上滑的下面三个加进数组
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row + 3 < self.dataArray.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row + 2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row + 3 inSection:0]];
            }
        }else{//想下滑的上面三个加进去
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row > 3) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row - 3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row - 2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:0]];
            }
        }
        [self.needLoadArray addObjectsFromArray:arr];
    }
    NSLog(@"需要加载的cell数组：%@---%f",self.needLoadArray,velocity.y);
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    scrollToToping = YES;
    return YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    scrollToToping = NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    scrollToToping = NO;
}

//用户触摸时第一时间加载内容
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!scrollToToping) {
        [_needLoadArray removeAllObjects];
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - setter and getter
- (NSMutableArray *)needLoadArray{
    if (!_needLoadArray) {
        _needLoadArray = [NSMutableArray array];
    }
    return _needLoadArray;
}

@end
