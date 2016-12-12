//
//  WebViewController.m
//  百思不得姐
//
//  Created by user on 16/9/13.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgress.h"
@interface WebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CallBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ComeInItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    
    self.webView.delegate=self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        NSLog(@"%f",progress);
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:self.url]]];
//    [mWebView setScalesPageToFit:YES];
   
    
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    
    self.progressView.progress=progress;
    self.progressView.hidden=(progress==1.0);
    
}
- (IBAction)CallBack:(id)sender {
    
    [self.webView goBack];//
}
- (IBAction)ComeIn:(id)sender {
    [self.webView goForward];
}
- (IBAction)Refresh:(id)sender {
    
    [self.webView reload];
}
#pragma mark-网页加载完毕时会来到这个界面
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //可以上前一个界面
    self.ComeInItem.enabled=webView.canGoForward;
    //可以往后一个界面
    self.CallBackItem.enabled=webView.canGoBack;
}

@end
