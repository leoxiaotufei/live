//
//  LCBaseWebViewController.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/5/2.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "BaseViewController.h"

@import WebKit;

typedef NS_ENUM(NSInteger){
    WebVieLoadTypeWebUrl,
    WebVieLoadTypeApp,
    WebVieLoadTypeHtmlStr
} WebVieLoadType;

@interface LCBaseWebViewController : BaseViewController

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) WKWebView *kWebView;


@property (nonatomic, assign) BOOL isFullMaskGame;


/**
 UrlString
 */
@property (nonatomic, copy  ) NSString *urlString;
/**
html字符串
 */
@property (nonatomic, strong) NSString  *contentStr;
/**
 默认WebVieLoadTypeWebUrl
 */
@property (nonatomic, assign) WebVieLoadType loadType;

@end
