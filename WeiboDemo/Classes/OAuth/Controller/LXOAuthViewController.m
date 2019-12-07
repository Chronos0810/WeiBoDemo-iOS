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
#import "LXAccount.h"
#import "AccountUtil.h"
#import "GlobalUtil.h"

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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = Client_ID;
    params[@"client_secret"] = @"179b0c3df4751fb73fad92ec2e4005b1";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = Redirect_Uri;
        
    [[AFHTTPSessionManager manager] POST:[NSString stringWithFormat:@"%@%@",BASE_URL,@"/oauth2/access_token"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GlobalLog(@"%@", responseObject);
        LXAccount *account = [LXAccount accountWithDict:responseObject];
        [AccountUtil saveAccount:account];
        
        GlobalKeyWindow.rootViewController = [GlobalUtil chooseRootViewController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
