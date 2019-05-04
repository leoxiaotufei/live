//
//  LCBaseWebViewController.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/5/2.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "LCBaseWebViewController.h"
#import "LCProgressView.h"

@interface LCBaseWebViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) LCProgressView *progressView;
@end

@implementation LCBaseWebViewController

- (instancetype)init {
    if (self = [super init]) {
        self.loadType = WebVieLoadTypeWebUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configWkWebView];
    [self.view addSubview:self.progressView];
    [self.view bringSubviewToFront:self.progressView];
    [self setupNavagitionBar];
    [self configDeviceOrientation];
    [self loadData];
}

#pragma mark -- 加载数据
- (void)loadData {
    
    if (self.loadType == WebVieLoadTypeHtmlStr) {
        [_kWebView loadHTMLString:_contentStr baseURL:nil];
    }else {
        //字符编码: URLQueryAllowedCharacterSet: ("#%<>[\]^`{|}) 可查看更多的编码集
        self.urlString = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_kWebView loadRequest:request];
    }
}
#pragma mark - navigationBar
- (void)setupNavagitionBar {
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick)];
    
}

- (void)backItemClick {
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - WKWebView相关配置
- (void)configWkWebView {
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    NSString *source = @"document.getElementsByClassName('footer bb')[0].style.display='none';";
    WKUserScriptInjectionTime injectionTime = WKUserScriptInjectionTimeAtDocumentStart;
    BOOL forMainFrameOnly = NO;
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:source
                                                  injectionTime:injectionTime
                                               forMainFrameOnly:forMainFrameOnly];
    [userContentController addUserScript:script];
    
    WKWebViewConfiguration *webViewConfiguration= [[WKWebViewConfiguration alloc] init];
    webViewConfiguration.userContentController = userContentController;
    
    webViewConfiguration.preferences = [[WKPreferences alloc] init];
    webViewConfiguration.preferences.minimumFontSize = 6;
    webViewConfiguration.preferences.javaScriptEnabled = YES;
    webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    webViewConfiguration.allowsInlineMediaPlayback = YES;
    
    _kWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, k_Height_NavBar, KScreenWidth, 0) configuration:webViewConfiguration];
    _kWebView.UIDelegate = self;
    _kWebView.navigationDelegate = self;
    _kWebView.allowsBackForwardNavigationGestures = YES;
    _kWebView.scrollView.showsVerticalScrollIndicator = NO;
    _kWebView.scrollView.showsHorizontalScrollIndicator = NO;
    [_kWebView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_kWebView];
}


#pragma mark ----- WKUIDelegate
//处理点击无反应的情况,会拷贝configuration创建一个新的webView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark ------ WKNavigationDelegate
//是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlStr = [NSString stringWithFormat:@"%@",navigationAction.request.URL.absoluteString];
    
    if(self.loadType == WebVieLoadTypeHtmlStr && navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
        
    }else if ([urlStr containsString:@"alipay://"] || [urlStr containsString:@"alipays://"]){
        NSURL *newUrl = [NSURL URLWithString:urlStr];
        if ([[UIApplication sharedApplication] canOpenURL:newUrl]) {
            [[UIApplication sharedApplication] openURL:newUrl];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}

//  web view页面开始接收数据
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
//web view加载完成, runJS
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.navigationController.interactivePopGestureRecognizer.enabled = ![webView canGoBack];
    NSString *currentUrl = [NSString stringWithFormat:@"%@",webView.URL.absoluteString];
    NSLog(@"currentUrl ====== %@",currentUrl);

}
//  加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"mark -----------------------------------------------------------  加载失败%@",error);
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

// 网页弹框 --- 确认弹框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

#pragma mark ----------------------------------------------------------- 网页弹框 --- 错误提示弹框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    if (message.length > 0) {
        
        NSString *cancle = @"取消";
        if ([message rangeOfString:@"成功"].location != NSNotFound ||
            [message rangeOfString:@"确定"].location != NSNotFound ||
            [message rangeOfString:@"确认"].location != NSNotFound) {
            cancle = @"确认";
        }
        
        [SVProgressHUD showInfoWithStatus:message];
        completionHandler();
    }else
        completionHandler();
}

//打开HTTPS的链接权限认证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if([challenge previousFailureCount] == 0) {
            NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        }else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
        }
       
    }else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
    }
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _kWebView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat newValue = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
            if (newValue == 1) {
                self.progressView.hidden = YES;
                self.progressView.frame  = CGRectMake(0, k_Height_NavBar, 0, 3);
            }else{
                self.progressView.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    self.progressView.frame = CGRectMake(0, k_Height_NavBar, KScreenWidth*newValue, 3);
                }];
            }
        }
    }
}

#pragma mark 配置设备方向
- (void)configDeviceOrientation {
    
    //设备方向
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        self.kWebView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    }else {
        self.kWebView.frame = CGRectMake(0, k_Height_NavBar, KScreenWidth, KScreenHeight);
    }
    
    [_kWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - getter
- (LCProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[LCProgressView alloc] initWithFrame:CGRectMake(0, k_Height_NavBar, 0, 3)];
    }
    return _progressView;
}

#pragma mark - 设备方向

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return  UIInterfaceOrientationMaskAll;
}

//设备方向改变
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationFaceUp) {
        return;
    }
    if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) { }
    else { }
    [self.view setNeedsLayout];
}

@end
