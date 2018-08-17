//
//  OCAndJSInteractionViewController.m
//  TestDemo
//
//  Created by Jack on 2018/5/20.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "OCAndJSInteractionViewController.h"
#import "OCCallJSViewController.h"
#import "JSCallOCViewController.h"

@interface OCAndJSInteractionViewController ()

@end

@implementation OCAndJSInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:button];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"occalljs" forState:UIControlStateNormal];
    button.center = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, 100);
    [button addTarget:self action:@selector(oc_call_js:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:button2];
    [button2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button2 setTitle:@"jscalloc" forState:UIControlStateNormal];
    button2.center = CGPointMake(UIScreen.mainScreen.bounds.size.width * 0.5, 200);
    [button2 addTarget:self action:@selector(js_call_oc:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)oc_call_js:(UIButton *)sender {
    OCCallJSViewController *vc = [[OCCallJSViewController alloc] initWithHTMLFileName:@"oc_call_js.html"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)js_call_oc:(UIButton *)sender {
    JSCallOCViewController *vc = [[JSCallOCViewController alloc] initWithHTMLFileName:@"js_call_oc.html"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
