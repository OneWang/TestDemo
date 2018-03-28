//
//  ViewController.m
//  TestDemo
//
//  Created by Jack on 2018/1/16.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <Masonry.h>
#import "UIView+ClipView.h"
#import "AssetViewController.h"
#import "ItemCell.h"
#import <objc/runtime.h>
#import "UIImage+ClipVIew.h"
#import "Person.h"
#import "SortAlgorithm.h"

@interface ViewController ()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/** player */
@property (strong, nonatomic) AVPlayer *player;
/** 进度条 */
@property (strong, nonatomic) UISlider *videoSlider;
/** 当前时间 */
@property (strong, nonatomic) UILabel *currentLabel;
/** 总时间 */
@property (strong, nonatomic) UILabel *totalLabel;
/** 播放按钮 */
@property (strong, nonatomic) UIButton *playButton;
/** 缓冲进度 */
@property (strong, nonatomic) UIProgressView *progressView;
/** 当前视频播放时间位置 */
@property (nonatomic, assign) NSInteger currentTime;
/** 视频播放时长 */
@property (nonatomic, strong) id observer;
/** 总时长 */
@property (assign, nonatomic) NSInteger totalTime;
/** slider上次的值 */
@property (nonatomic, assign) CGFloat sliderLastValue;
/** 缓冲是否结束 */
@property (assign, nonatomic) BOOL isBufferFinish;
/** collectionview */
@property (weak, nonatomic) UICollectionView *collectionView;
/** 照片数组 */
@property (strong, nonatomic) NSArray *photoArray;

@end

@implementation ViewController

//- (instancetype)init{
//    if (self = [super init]) {
//        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initwith" userInfo:nil];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    SortAlgorithm *sort = [[SortAlgorithm alloc] init];

    [self testGCDSemaphore];
}

- (void)testGCDSemaphore{
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建信号量，并且设置值为10
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++){
        // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i===%@",i,[NSThread currentThread]);
            sleep(2);
            // 每次发送信号则semaphore会+1，
            dispatch_semaphore_signal(semaphore);
        });
//        dispatch_async(queue, ^{
//            NSLog(@"%i===%@",i,[NSThread currentThread]);
//            sleep(2);
//            // 每次发送信号则semaphore会+1，
//            dispatch_semaphore_signal(semaphore);
//        });
    }
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 10; i ++) {
//        dispatch_async(queue, ^{
//            NSLog(@"%d===%@",i,[NSThread currentThread]);
//            sleep(3);
//            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//            [array addObject:@(i)];
//            NSLog(@"后%d===%@",i,[NSThread currentThread]);
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
}

//测试两个字符串的初始化
- (void)testStringAddress{
    NSString *str1 = @"123";
    NSString *str2 = [NSString stringWithFormat:@"%@",@"123"];
    if (str1 == str2) {
        NSLog(@"as");
    }else{
        NSLog(@"sdf");
    }
}

#pragma mark - block作为参数和返回值的使用
- (void)testFunction{
    [self setUpTitleEffect:^(NSString *__autoreleasing *title, CGFloat *width) {
        *title = @"我是指针的指针";
        *width = 12.5;
    }];
    
    NSString *string = @"单独的指针";
    CGFloat count = 109043.f;
    [self setupTitleWithSting:&string andWidth:&count];
}

- (void)testBlock{
    void(^testblock)(int n) = [self createFunctionWithString:^NSString *(NSArray *numarray) {
        NSMutableString *string = [NSMutableString string];
        for (NSString *str in numarray) {
            NSLog(@"%@",str);
            [string appendString:str];
        }
        return string;
    }];
    if (testblock) {
        testblock(8);
    }
}

- (void(^)(int number))createFunctionWithString:(NSString *(^)(NSArray *))stringBlock{
    if (stringBlock) {
        NSLog(@"%@",stringBlock(@[@"d",@"d"]));
    }
    return ^(int num){
        if (stringBlock) {
            NSLog(@"%@",stringBlock(@[@"嗯我若无",@"发生的",@"fas"]));
        }
    };
}

#pragma mark - 使用指向指针的指针进行传值
- (void)setUpTitleEffect:(void(^)(NSString **title,CGFloat *width))titleEffectBlock{
    NSString *title;
    CGFloat width;
    if (titleEffectBlock) {
        titleEffectBlock(&title,&width);
        NSLog(@"%@===%f",title,width);
    }
}

- (void)setupTitleWithSting:(NSString **)string andWidth:(CGFloat *)width{
    NSLog(@"%@=====%f",*string,*width);
}

- (void)testIvarList{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([NSObject class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSObject *value = [[NSObject new] valueForKey:[NSString stringWithUTF8String:name]];
        NSLog(@"%@",value);
    }
}

//测试指针的变换
- (void)testPointer{
    int arrayName[4] = {10,20,30,40};
    int *p = (int *)(&arrayName + 1);

    NSLog(@"%d",*(p - 1));
    NSLog(@"%p===%p",&arrayName,&arrayName + 1);

    NSLog(@"%p----%d++++++%d",p - 1,*(p - 1),*p);
}

- (void)textconvertRect{
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    [self.view addSubview:red];
    red.backgroundColor = [UIColor redColor];
    
    UIView *blue = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
    [red addSubview:blue];
    blue.backgroundColor = [UIColor blueColor];
    
    CGRect rect = [red convertRect:blue.frame toView:self.view];
    NSLog(@"%@",NSStringFromCGRect(rect));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
}

- (void)nsurlsessonTest{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@""]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)createCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat item_w = ([UIScreen mainScreen].bounds.size.width - 25) / 4;
    layout.itemSize = CGSizeMake(item_w, item_w);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, item_w * 2 + 15) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    collection.delegate = self;
    collection.dataSource = self;
    [self.view addSubview:collection];
    [collection registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    self.collectionView = collection;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.photoArray.count == 8) {
        return self.photoArray.count;
    }else{
        return self.photoArray.count + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    if (indexPath.item < self.photoArray.count) {
        cell.assetModel = self.photoArray[indexPath.item];
    }else{
        cell.assetModel = nil;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.photoArray.count == indexPath.item) {
        AssetViewController *assetVC = [[AssetViewController alloc] init];
        assetVC.selectImage = ^(NSArray *imageArray) {
            self.photoArray = imageArray;
            [self.collectionView reloadData];
        };
        if (self.photoArray.count) {
            assetVC.selectImages = self.photoArray;
        }
        [self presentViewController:assetVC animated:YES completion:nil];
    }
}

- (void)drawCurveCorner{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
//    imageView.image = [image cutCircleImage];
    imageView.image = image;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    [self.view addSubview:imageView];
    
    
//    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
//    imageview.center = self.view.center;
//    imageview.image = [UIImage imageNamed:@"屏幕快照 2018-01-18 下午6.04.02"];
//    //开始对imageView进行画图
//    UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, true, 0);
//    //使用贝塞尔曲线画出一个圆形图
//    [[UIBezierPath bezierPathWithOvalInRect:imageview.bounds] addClip];
//    [imageview drawRect:imageview.bounds];
//    imageview.image = UIGraphicsGetImageFromCurrentImageContext();
//    //结束画图
//    UIGraphicsEndImageContext();
//    [self.view addSubview:imageview];
//    [[UIColor whiteColor] setFill];
//    UIRectFill(imageView.bounds);
}

- (void)setupPlayer{
    //http://publicdfs.exinlei.com/ueditor/file/088a98e8d0a94fc7b44859a92f6e0e8e.mp3
    NSString *path = @"http://publicdfs.exinlei.com/ueditor/file/088a98e8d0a94fc7b44859a92f6e0e8e.mp3";
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:path]];
//    [self addObserverToPlayerItem:playerItem];
    _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    [self addProgressObserver];

//    [_player play];
}

- (void)createChildViews{
    [self.view addSubview:self.playButton];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.videoSlider];
    [self.view addSubview:self.currentLabel];
    [self.view addSubview:self.totalLabel];
    [self addNotifcation];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(10);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentLabel.mas_right).offset(10);
        make.right.equalTo(self.totalLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.equalTo(@30);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentLabel.mas_right).offset(10);
        make.right.equalTo(self.totalLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.view.mas_centerY).offset(1);
        make.height.equalTo(@2);
    }];
}

//添加通知
- (void)addNotifcation{
    //挂起
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    //进入后台
    [notification addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    //播放完成
    [notification addObserver:self selector:@selector(playbackFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

/**
 播放结束的通知
 
 @param notification 通知
 */
- (void)playbackFinish:(NSNotification *)notification{
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    self.currentLabel.text = @"00:00:00";
    self.totalLabel.text = [self displayTime:self.totalTime];
    self.videoSlider.value = 0.0;
    
    [self.player seekToTime:CMTimeMake(0, 1) toleranceBefore:CMTimeMake(1, 1) toleranceAfter:CMTimeMake(1, 1) completionHandler:^(BOOL finished) {
    }];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification{
    if (self.player.rate == 0) {
        [self.player play];
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification{
    if (self.player.rate == 1) {
        [self.player pause];
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    }
}

//播放进度观察者
- (void)addProgressObserver{
    AVPlayerItem *playerItem = self.player.currentItem;
    //这里设置每秒执行一次
    __weak typeof(self) weakSelf = self;
    self.observer = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(playerItem.duration);
        weakSelf.currentTime = current;
        if (current) {
            weakSelf.videoSlider.value = current/total;
            weakSelf.currentLabel.text = [weakSelf displayTime:current];
            weakSelf.totalLabel.text = [weakSelf displayTime:total];
        }
    }];
}

- (NSString *)displayTime:(NSInteger)timeInterval{
    NSString *time = @"";
    NSInteger seconds = timeInterval % 60;
    NSInteger minutes = (timeInterval / 60) % 60;
    NSInteger hours = timeInterval / 3600;
    NSString *secondStr = seconds < 10 ? [NSString stringWithFormat:@"0%zd",seconds] : [NSString stringWithFormat:@"%zd",seconds];
    NSString *minuteStr = minutes < 10 ? [NSString stringWithFormat:@"0%zd",minutes] : [NSString stringWithFormat:@"%zd",minutes];
    NSString *hourStr = hours < 10 ? [NSString stringWithFormat:@"0%zd",hours] : [NSString stringWithFormat:@"%zd",hours];
    time = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minuteStr,secondStr];
    return time;
}

/**
 添加观察者
 */
- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性,注意 AVPlayer 也有一个 status 属性,通过监控它的 status 也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的的区域缓存是否为空
    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 移出观察者
 */
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    if (self.observer) {
        [self.player removeTimeObserver:self.observer];
        self.observer = nil;
    }
}

#pragma maark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {  //监控状态属性,注意 AVPlayer 也有一个 status 属性,通过监控它的 status 也可以获得播放状态
        AVPlayerStatus status = [[change objectForKey:@"new"] integerValue];
        if (status == AVPlayerStatusReadyToPlay) {      //准备播放
            self.totalTime = CMTimeGetSeconds(playerItem.duration);
            [self.player pause];
        }else if (status == AVPlayerStatusUnknown){
            NSLog(@"AVPlayerStatusUnknown");
        }else if (status == AVPlayerStatusFailed){
            self.isBufferFinish = NO;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){       //监控网络加载情况属性
        NSArray *array = playerItem.loadedTimeRanges;
        //本次缓冲的时间范围
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        //缓冲总长度
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
        if (self.currentTime < (startSeconds + durationSeconds + 8)) {
            self.isBufferFinish = YES;
            if ([self.playButton.titleLabel.text isEqualToString:@"暂停"]) {
                [self.player play];
            }
        }else{
            self.isBufferFinish = NO;
        }
        float total = CMTimeGetSeconds(self.player.currentItem.duration);
        self.progressView.progress = totalBuffer / total;
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){      //监听播放的的区域缓存是否为空
        // 当缓冲是空的时候
        if (self.player.currentItem.playbackBufferEmpty) {
            [self bufferingSomeSecond];
        }
    }else if ([keyPath isEqualToString:@"playbackLikeToKeepUp"]){   //缓存可以播放的时候调用
        if (self.player.currentItem.playbackLikelyToKeepUp) {
            self.isBufferFinish = YES;
        }
    }
}

#pragma mark - 缓冲较差时候
/**
 *  缓冲较差时候回调这里
 */
- (void)bufferingSomeSecond {
    self.isBufferFinish = NO;
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 如果此时用户已经暂停了，则不再需要开启播放了
        //        if (self.isPauseByUser) {
        //            isBuffering = NO;
        //            return;
        //        }
        [self.player play];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.player.currentItem.isPlaybackLikelyToKeepUp) { [self bufferingSomeSecond]; }
    });
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGRect rect = [self thumbRect];
    CGPoint point = [touch locationInView:self.videoSlider];
    if ([touch.view isKindOfClass:[UISlider class]]) { // 如果在滑块上点击就不响应pan手势
        if (point.x <= rect.origin.x + rect.size.width && point.x >= rect.origin.x) { return NO; }
    }
    return YES;
}

/**
 slider滑块的bounds
 */
- (CGRect)thumbRect {
    return [self.videoSlider thumbRectForBounds:self.videoSlider.bounds
                                      trackRect:[self.videoSlider trackRectForBounds:self.videoSlider.bounds]
                                          value:self.videoSlider.value];
}

#pragma mark - private method
- (void)playButtonClick:(UIButton *)button{
    if (!self.isBufferFinish) {
        return;
    }
    if (self.player.rate == 0) {
        [self.player play];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [self.player pause];
        [button setTitle:@"播放" forState:UIControlStateNormal];
    }
}

// slider开始滑动事件
- (void)progressSliderTouchBegan:(UISlider *)slider{}

- (void)progressSliderValueChanged:(UISlider *)slider{
    //拖动改变视频的播放进度
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        BOOL style = NO;
        CGFloat value = slider.value - self.sliderLastValue;
        if (value > 0) { style = YES; }
        if(value < 0){ style = NO; }
        if(value == 0){ return; }
        
        self.sliderLastValue = slider.value;
        CGFloat totalTime = (CGFloat)self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
        //计算出拖动的当前秒数
        CGFloat dragedSeconds = floorf(totalTime * slider.value);
        
        // 拖拽的时长
        NSInteger proMin = dragedSeconds / 60;//当前秒
        NSInteger proSec = (NSInteger)dragedSeconds % 60;//当前分钟
        
        CGFloat  draggedValue = (CGFloat)dragedSeconds/(CGFloat)totalTime;
        NSString *currentTimeStr = [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
        
        self.videoSlider.value = draggedValue;
        self.currentLabel.text = currentTimeStr;
        
        if (totalTime > 0) {        // 当总时长 > 0时候才能拖动slider
            
        }else{
            self.videoSlider.value = 0;
        }
    }else{
        self.videoSlider.value = 0;
    }
}

- (void)progressSliderTouchEnded:(UISlider *)slider{
    [self.player seekToTime:CMTimeMakeWithSeconds(self.totalTime * self.videoSlider.value, self.player.currentItem.duration.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            [self.player play];
            [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }];
}

- (void)tapSliderAction:(UITapGestureRecognizer *)gecognizer{
    UISlider *slider = (UISlider *)gecognizer.view;
    CGPoint point = [gecognizer locationInView:slider];
    CGFloat length = slider.frame.size.width;
    // 视频跳转的value
    CGFloat tapValue = point.x / length;
    // 视频总时间长度
    CGFloat total = (CGFloat)self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    //播放
    [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self.player play];
    //计算出拖动的当前秒数
    NSInteger dragedSeconds = floorf(total * tapValue);
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [self.player seekToTime:dragedCMTime toleranceBefore:CMTimeMake(1, 1) toleranceAfter:CMTimeMake(1, 1) completionHandler:^(BOOL finished) {}];
}

// 不做处理，只是为了滑动slider其他地方不响应其他手势
- (void)panRecognizer:(UIPanGestureRecognizer *)panGesture{}

#pragma mark - setter and getter
- (UISlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider                       = [[UISlider alloc] init];
        [_videoSlider setThumbImage:[UIImage imageNamed:@"ZFPlayer_slider"] forState:UIControlStateNormal];
        _videoSlider.maximumValue          = 1;
        _videoSlider.minimumTrackTintColor = [UIColor whiteColor];
        _videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        
        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
        [_videoSlider addGestureRecognizer:sliderTap];
        
        //平移
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
        panRecognizer.delegate = self;
        [panRecognizer setMaximumNumberOfTouches:1];
        [panRecognizer setDelaysTouchesBegan:YES];
        [panRecognizer setDelaysTouchesEnded:YES];
        [panRecognizer setCancelsTouchesInView:YES];
        [_videoSlider addGestureRecognizer:panRecognizer];
    }
    return _videoSlider;
}

- (UILabel *)currentLabel{
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc] init];
        _currentLabel.textAlignment = NSTextAlignmentCenter;
        _currentLabel.font = [UIFont systemFontOfSize:12];
        _currentLabel.textColor = [UIColor whiteColor];
        _currentLabel.text = @"00:00:00";
    }
    return _currentLabel;
}

- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.font = [UIFont systemFontOfSize:12];
        _totalLabel.text = @"00:00:00";
    }
    return _totalLabel;
}

- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        _playButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        _progressView.trackTintColor    = [UIColor clearColor];
    }
    return _progressView;
}

- (void)dealloc{
    [self removeObserverFromPlayerItem:self.player.currentItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
