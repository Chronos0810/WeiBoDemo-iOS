//
//  LXOAuthViewController.m
//  WeiboDemo
//
//  Created by Werner on 2019/12/7.
//  Copyright © 2019 Werner. All rights reserved.
//

#import "LXOAuthViewController.h"
#import "MBProgressHUD+Ext.h"
#import "AFNetworking.h"
#import "GlobalUtil.h"
#import "AccountUtil.h"

#define Client_ID    @"2975493909"
#define Redirect_Uri @"http://www.baidu.com"

@interface LXOAuthViewController ()<UIWebViewDelegate>

@end

@implementation LXOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,Client_ID, Redirect_Uri]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    webView.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"loading"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

- (void)accessTokenWithCode:(NSString *)code{
    
    [AccountUtil accountWithCode:code success:^{
        GlobalKeyWindow.rootViewController = [GlobalUtil chooseRootViewController];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
