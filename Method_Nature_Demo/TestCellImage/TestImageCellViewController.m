//
//  TestImageCellViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/14.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "TestImageCellViewController.h"
#import "ImageCell.h"
#import "ImageModel.h"
#import <YYModel.h>

@interface TestImageCellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tablView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *images;
@end

@implementation TestImageCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
//    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
//    for (NSDictionary *dict in data1) {
//        ImageModel *mode = [ImageModel yy_modelWithJSON:dict];
//        [self.dataArray addObject:mode];
//    }
    [self crateChildView];
}

- (void)crateChildView{
    UITableView *tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tablView];
//    tablView.estimatedRowHeight = 120;
    [self.view addSubview:tablView];
    tablView.delegate = self;
    tablView.dataSource = self;
    
//    NSDate *date = [NSDate date];
}

#pragma mark ***************************** UITableViewDelegate,UITableViewDataSource *****************************
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"%s",__func__);
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [ImageCell cellWithTableView:tableView];
    cell.imageName = self.images[indexPath.row];
    NSLog(@"%s---%zd",__func__,indexPath.row);
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%s---%zd",__func__,indexPath.row);
//    return 120;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    NSLog(@"%s",__func__);
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    NSLog(@"%s",__func__);
    return 20.f;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}

@end
