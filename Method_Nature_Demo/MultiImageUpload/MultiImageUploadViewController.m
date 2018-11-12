//
//  MultiImageUploadViewController.m
//  Method_Nature_Demo
//
//  Created by Jack on 2018/11/11.
//  Copyright © 2018 Jack. All rights reserved.
//

#import "MultiImageUploadViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "MLURLSessionWrapperOperation.h"

@interface MultiImageUploadViewController ()

@end

@implementation MultiImageUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 多图上传主要分为三种方式来实现
 */
//1.GCD
- (NSURLSessionUploadTask *)uploadTaskWithImage:(UIImage *)image completion:(void(^)(NSURLResponse *reponse, id responseObject, NSError *error))completionBlock{
    // 构造 NSURLRequest
    NSError *error;
    NSMutableURLRequest *urlRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"someFileName" mimeType:@"multipart/form-data"];
    } error:&error];
    
    // 可在此处配置验证信息
    
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *dataTask = [manager uploadTaskWithRequest:urlRequest fromData:UIImageJPEGRepresentation(image, 1.0) progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:completionBlock];
    return dataTask;
}

- (void)multiImageUploadTest{
    //需要上传的数据
    NSArray *dataArray = [NSArray array];
    
    NSMutableArray *result = [NSMutableArray array];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:[NSNull null]];
    }];
    
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < dataArray.count; i ++) {
        dispatch_group_enter(group);
        NSURLSessionUploadTask *dataTask = [self uploadTaskWithImage:dataArray[i] completion:^(NSURLResponse *reponse, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
                dispatch_group_leave(group);
            } else {
                NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                    result[i] = responseObject;
                }
                dispatch_group_leave(group);
            }
        }];
        [dataTask resume];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        for (id response in result) {
            NSLog(@"%@", response);
        }
    });
}

- (void)testOperation{
    // 需要上传的数据
    NSArray *images = [NSMutableArray array];
    
    // 准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray* result = [NSMutableArray array];
    for (UIImage *image in images) {
        [result addObject:[NSNull null]];
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 5;
    
    NSBlockOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{ // 回到主线程执行，方便更新 UI 等
            NSLog(@"上传完成!");
            for (id response in result) {
                NSLog(@"%@", response);
            }
        }];
    }];
    
    for (NSInteger i = 0; i < images.count; i++) {
        NSURLSessionUploadTask *uploadTask = [self uploadTaskWithImage:images[i] completion:^(NSURLResponse *response, NSDictionary *responseObject, NSError *error) {
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
            } else {
                NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                @synchronized (result) { // NSMutableArray 是线程不安全的，所以加个同步锁
                    result[i] = responseObject;
                }
            }
        }];
        MLURLSessionWrapperOperation *uploadOperation = [MLURLSessionWrapperOperation operationWithURLSessionTask:uploadTask];
        [completionOperation addDependency:uploadOperation];
        [queue addOperation:uploadOperation];
    }
    [queue addOperation:completionOperation];
}

@end
