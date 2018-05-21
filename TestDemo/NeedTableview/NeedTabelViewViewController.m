//
//  NeedTabelViewViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/21.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "NeedTabelViewViewController.h"
#import "EXLNeededTabeleView.h"
#import "YYFPSLabel.h"

@interface NeedTabelViewViewController ()
/** tableView */
@property (strong, nonatomic) EXLNeededTabeleView *tableView;
@end

@implementation NeedTabelViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[EXLNeededTabeleView alloc] initWithFrame:UIScreen.mainScreen.bounds style:UITableViewStyleGrouped];
    
    YYFPSLabel *label = [[YYFPSLabel alloc] initWithFrame:CGRectMake(100, 20, 100, 30)];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [self.view addSubview:_tableView];
    _tableView.dataArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
}

@end
