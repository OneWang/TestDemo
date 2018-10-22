//
//  JSCallOCViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/21.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "JSCallOCViewController.h"

@interface JSCallOCViewController ()

@end

@implementation JSCallOCViewController

- (void)loadNavItems{
    self.navigationItem.title = @"JS调用OC代码";
}

#pragma mark- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [self presentViewController:nil animated:YES completion:nil];
    
    __weak typeof(self)this = self;
    self.context[@"tapAndLogAction"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [this showAlertViewWithMessage:@"我被点击啦"];
        });
    };
    
    self.context[@"logTextFieldInput"] = ^(NSString *textFieldString){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *message = textFieldString.length? textFieldString : @"请在提示框内输入文字哦";
            [this showAlertViewWithMessage:message];
        });
    };
}

@end
