//
//  BreakPointDownLoad.m
//  TestDemo
//
//  Created by Jack on 2018/3/30.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "BreakPointDownLoad.h"

@interface BreakPointDownLoad ()<NSURLSessionDownloadDelegate>

@end

@implementation BreakPointDownLoad

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setupDownload{
    static NSString *identifer = @"session config";
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifer];
    
    NSURL *url = [NSURL URLWithString:@""];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *dataTask = [session downloadTaskWithURL:url];
    
    [dataTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate
/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                              didFinishDownloadingToURL:(NSURL *)location{
    
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
                              totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                      didResumeAtOffset:(int64_t)fileOffset
                                     expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

@end
