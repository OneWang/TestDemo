//
//  MainViewController.m
//  TestDemo
//
//  Created by Jack on 2018/4/7.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "MainViewController.h"
#import "ARCAndMRCViewController.h"
#import "MainModel.h"
#import <YYModel.h>

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (strong, nonatomic) UITableView *tableView;
/** 数据源数组 */
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self createChildViews];
}

- (void)initData{
    MainModel *model1 = [MainModel yy_modelWithJSON:@{@"name":NSStringFromClass([ARCAndMRCViewController class]),@"destationVC":[ARCAndMRCViewController class]}];
    [self.dataArray addObject:model1];
}

- (void)createChildViews{
    self.navigationItem.title = @"testDemo";
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    MainModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainModel *model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:[[model.destationVC alloc] init] animated:YES];
}

#pragma mark - setter and geter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
