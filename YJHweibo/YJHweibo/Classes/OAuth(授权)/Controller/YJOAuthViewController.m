//
//  YJOAuthViewController.m
//  YJHweibo
//
//  Created by YJH on 16/4/8.
//  Copyright © 2016年 YJH. All rights reserved.
//

//  App Key：3346461650
//  App Secret：4a569d4cab9053d194429604dc524d19
//  client_id     376128077
//  redirect_uri  http://baidu.com 回调地址配置-->默认是http://

#import "YJOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YJAccountTool.h"
@interface YJOAuthViewController () <UIWebViewDelegate>

@end

@implementation YJOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *Webview = [[UIWebView alloc]init];
    Webview.frame = self.view.bounds;
    Webview.delegate = self;
    [self.view addSubview:Webview];
    
    // 加载新浪登录页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3346461650&redirect_uri=http://baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [Webview loadRequest:request];

}
#pragma mark WebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"ViewDidFinishLoad");
    [MBProgressHUD hideHUD];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"ViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载..."];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
// 拦截数据
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获得 url
    NSString *url = request.URL.absoluteString;
    // 搜索字符串：判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        // 截取code后面参数值
        long fromIdex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIdex];
        
        // 利用 code 获取 accessToke
        [self accessTokeWith:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
//    NSLog(@"shouldStartLoadWithRequest -- %@",request.URL.absoluteString);
    
    return YES;
}

-(void)accessTokeWith:(NSString *)code
{
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *ditc = [NSMutableDictionary dictionary];
    ditc[@"client_id"] = @"3346461650";
    ditc[@"client_secret"] = @"4a569d4cab9053d194429604dc524d19";
    ditc[@"grant_type"] = @"authorization_code";
    ditc[@"redirect_uri"] = @"http://baidu.com";
    ditc[@"code"] = code;
    
    AFHTTPRequestOperationManager *mager = [AFHTTPRequestOperationManager manager];
    [mager POST:url parameters:ditc success:^(AFHTTPRequestOperation *operation,  NSDictionary *responseObject) {
        NSLog(@"responseObject =%@",responseObject);
        [MBProgressHUD hideHUD];

        // 将返回账号的字典数据--->转成模型 --->再存进沙盒
        YJAccount *account = [YJAccount accountWithDict:responseObject];
        // 存储账号信息到沙盒
        [YJAccountTool saveAccount:account];
#pragma mark 切换窗口根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error =%@",error);
        [MBProgressHUD hideHUD];
    }];
}


@end
