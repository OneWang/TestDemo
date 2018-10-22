//
//  WebViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/20.
//  Copyright © 2018年 Jack. All rights reserved.

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<UIWebViewDelegate>
/** webview */
@property (strong, nonatomic) UIWebView *webView;
/** 小菊花 */
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) NSString *htmlFileName;
@end

@implementation WebViewController

- (instancetype)initWithHTMLFileName:(NSString *)htmlFileName{
    self = [super init];
    if (self) {
        self.htmlFileName = htmlFileName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *view = [[WKWebView alloc] init];
    [self.view addSubview:view];
    
    [self createChildViews];
    [self loadNavItems];
    [self requestHTML];
}

- (void)loadNavItems{
    //交给子类去做
}

- (void)createChildViews{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicatorView.frame = CGRectMake(self.webView.center.x - 20, 120, 40, 40);
    [self.webView addSubview:self.indicatorView];
}

- (void)requestHTML{
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:self.htmlFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest: request];
    [self.indicatorView startAnimating];
}

#pragma mark ***************************** UIWebViewDelegate *****************************
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.indicatorView stopAnimating];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //保存上下文
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //捕获js里面的异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
        context.exception = exceptionValue;
    };
}

- (void)showAlertViewWithMessage:(NSString *)message{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [vc addAction:cancelAction];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)test{
    JSValue *intValue = [JSValue valueWithInt32:10 inContext:self.context];
    JSValue *boolValue = [JSValue valueWithBool:YES inContext:self.context];
    
    JSValue *person = [JSValue valueWithNewObjectInContext:self.context];
    [person setObject:@"OneWang" forKeyedSubscript:@"name"];
    [person setObject:@27 forKeyedSubscript:@"age"];
    NSLog(@"%@----%@-----%@-----%@",person[@"name"],person[@"age"],intValue.toString,boolValue.toString);
    
    [self.context evaluateScript:@"function add(a,b){return a + b}"];
    JSValue *value = [self.context[@"add"] callWithArguments:@[@2,@2]];
    NSLog(@"%@",value.toString);
}

@end
