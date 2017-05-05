//
//  ScrollViewController.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/6.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "ScrollViewController.h"
#import <SDAutoLayout.h>
@interface ScrollViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 导航返回按钮
    UIImage *image = [UIImage imageNamed:@"返回箭头"];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.title = self.titleStr;
    // 创建网页
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.detectsPhoneNumbers = YES;// 自动检测网站的电话号码 单击可通话
    [self.view addSubview:_webView];
    
    _webView.backgroundColor = [UIColor clearColor];
    
    // 适配
    _webView.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(self.view.height-64);
    
    // 加载网页
    NSURL *url = [NSURL URLWithString:self.html_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    
}
// 去广告
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(topBannerChapin_wrapper_u2854143).style.display='none'"];
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(container).style.display='none'"];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
