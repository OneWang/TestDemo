//
//  WebViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/20.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
/** webview */
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createChildViews];
}

- (void)createChildViews{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
}

@end
