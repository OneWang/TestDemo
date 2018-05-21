//
//  WebViewController.h
//  TestDemo
//
//  Created by Jack on 2018/5/20.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController : UIViewController
@property (nonatomic, strong) JSContext *context;

//以html文件名出实话子类
- (instancetype)initWithHTMLFileName:(NSString * )htmlFileName;

//由子类实现，定义自己的导航栏标题，按钮等等
- (void)loadNavItems;

//webView的回调
- (void)webViewDidFinishLoad:(UIWebView *)webView;

//弹窗，主要用来反映从js传来的事件或者对象
- (void)showAlertViewWithMessage:(NSString *)message;

@end
