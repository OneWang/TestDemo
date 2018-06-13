//
//  MultiImageDownloadCacheViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/18.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "MultiImageDownloadCacheViewController.h"
#import "DownloadImage.h"

@interface MultiImageDownloadCacheViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 数据源数组 */
@property (strong, nonatomic) NSArray<DownloadImage *> *dataArray;
/** 内存缓存 */
@property (strong, nonatomic) NSCache *iamgeCache;
/** 操作缓存 */
@property (strong, nonatomic) NSMutableDictionary<NSString *,NSBlockOperation *> *operationDict;
/** 队列 */
@property (strong, nonatomic) NSOperationQueue *queue;
@end

@implementation MultiImageDownloadCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"test" object:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
    }];
}

- (void)test{
    NSLog(@"---------%@",[NSThread currentThread]);
}

#pragma mark ***************************** UITableViewDelegate,UITableViewDataSource *****************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    DownloadImage *model = self.dataArray[indexPath.row];
    //首先查询内存中的缓存
    UIImage *image = [self.iamgeCache objectForKey:model.icon];
    
    if (image) {    //找到缓存
        cell.imageView.image = image;
    }else{      //没有缓存去磁盘缓存中找
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        NSString *fileName = [model.icon lastPathComponent];
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        if (imageData) {    //找到磁盘缓存
            cell.imageView.image = [UIImage imageWithData:imageData];
            //然后将磁盘缓存存放到内存缓存中
            [self.iamgeCache setObject  :imageData forKey:model.icon];
        }else{      //没有磁盘缓存就到操作队列中去查找
            NSBlockOperation *operation = [self.operationDict objectForKey:model.icon];
            if (!operation) {    //如果有这个图片下载的操作就什么都不做,没有的话在进行下载
                //下载之前先设置占位符
                cell.imageView.image = [UIImage imageNamed:@"photo_def_photoPickerVc"];
                //创建下载操作
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *imageUrl = [NSURL URLWithString:model.icon];
                    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
                    UIImage *downImage = [UIImage imageWithData:data];
                    if (!downImage) {    //如果没有下载到图片就退出,并将此操作从操作队列中移出
                        [self.operationDict removeObjectForKey:model.icon];
                        return ;
                    }
                    
                    //有图片的话就依次更新内存缓存和磁盘缓存
                    [self.iamgeCache setObject:downImage forKey:model.icon];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    }];
                    
                    [imageData writeToFile:filePath atomically:YES];
                    [self.operationDict removeObjectForKey:model.icon];
                }];
                //将操作添加到操作缓存中
                [self.operationDict setObject:operation forKey:model.icon];
                //添加到队列中
                [self.queue addOperation:operation];
            }
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark ***************************** setter and getter *****************************
- (NSArray<DownloadImage *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
        NSArray *imageArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"appsInfo.plist" ofType:nil]];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in imageArray) {
            [tempArray addObject:[DownloadImage modelWithDict:dict]];
        }
        _dataArray = tempArray;
    }
    return _dataArray;
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 6;
    }
    return _queue;
}

- (NSMutableDictionary<NSString *,NSBlockOperation *> *)operationDict{
    if (!_operationDict) {
        _operationDict = [NSMutableDictionary dictionary];
    }
    return _operationDict;
}

- (NSCache *)iamgeCache{
    if (!_iamgeCache) {
        _iamgeCache = [[NSCache alloc] init];
    }
    return _iamgeCache;
}

@end
