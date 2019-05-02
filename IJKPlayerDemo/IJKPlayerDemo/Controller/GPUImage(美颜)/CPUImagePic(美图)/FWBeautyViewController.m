//
//  FWBeautyViewController.m
//  FWMeituApp
//
//  Created by ForrestWoo on 15-9-19.
//  Copyright (c) 2015年 ForrestWoo co,.ltd. All rights reserved.
//

#define kWidth 50
#define kHeight 67

#import "UIImage+ImageScale.h"
#import "FWBeautyViewController.h"
#import "FWAutoBeautyViewController.h"
#import "FWEditViewController.h"
#import "FWColorListViewController.h"
#import "FWBorderViewController.h"
#import "GPUImagePicViewController.h"
#import "FWBlurViewController.h"
#import "FWFiltersViewController.h"
@interface FWBeautyViewController ()
{
    CGFloat beginY;
}
@end

@implementation FWBeautyViewController

- (id)initWithImage:(UIImage *)image
{
    if (self = [super init]) {
        self.image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor blackColor];
    //asd
    self.title = @"美化图片";
    
    modeView = [FWButton buttonWithType:UIButtonTypeCustom];
    [modeView setTitle:@"去美容" forState:UIControlStateNormal];
    [modeView setImage:[UIImage imageNamed:@"ic_function_meirong_a@2x.png"] forState:UIControlStateNormal];
    [modeView setImage:[UIImage imageNamed:@"ic_function_meirong_b@2x.png"] forState:UIControlStateHighlighted];
    [modeView setBackgroundColor:[UIColor clearColor]];
    [modeView.titleLabel setFont:[UIFont systemFontOfSize:10]];
    beginY = KScreenHeight - kHeight;
    modeView.frame = CGRectMake(KScreenWidth - kWidth, beginY, kWidth, kHeight);
    highlightedTextColor = [UIColor colorWithRed:19 / 255.0 green:105 / 255.0 blue:240 / 255.0 alpha:1.0];
    modeView.highlightedTextColor = highlightedTextColor;
    modeView.topPading = 3;
    [modeView addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *tagImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mc_line@2x.png"]];
    tagImage.frame = CGRectMake(KScreenWidth - kWidth - 2, KScreenHeight - kHeight + 10, 1, 50);
    tagImage.clipsToBounds = YES;
    [self.view addSubview:modeView];
    [self.view addSubview:tagImage];
    [self initImageView];
    [self initScrolleView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)initImageView
{
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.frame = CGRectMake(0, 44, KScreenWidth, KScreenHeight - 44 - kHeight);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.imageView];
}

- (void)initScrolleView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, beginY, KScreenWidth - kWidth - 2, kHeight)];
    self.scrollView.contentSize = CGSizeMake(580, kHeight - 10);
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    NSArray *normalImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_a",
                                        @"icon_function_edit_a@2x.png", @"icon_function_color_a@2x.png", @"icon_function_stylize_a@2x.png",
                                        @"icon_function_border_a@2x.png", @"icon_function_mohuanbi_a@2x.png", @"icon_function_mosaic_a@2x.png",
                                        @"icon_function_text_a@2x.png", @"icon_function_bokeh_a@2x.png",
                                        nil];
    NSArray *hightlightedImageViewImageArr = [NSArray arrayWithObjects:@"icon_function_autoBeauty_b@2x.png",
                                              @"icon_function_edit_b@2x.png", @"icon_function_color_b@2x.png", @"icon_function_stylize_b@2x.png",
                                              @"icon_function_border_b@2x.png", @"icon_function_mohuanbi_b@2x.png", @"icon_function_mosaic_b@2x.png",
                                              @"icon_function_text_b@2x.png", @"icon_function_bokeh_b@2x.png",
                                              nil];
    NSArray *textArr = [NSArray arrayWithObjects:@"智能优化", @"编辑", @"增强", @"特效", @"边框", @"魔幻笔", @"马赛克", @"文字", @"背景虚化", nil];
    
    //ox 4 pad 15
    FWButton *btFunction = nil;
    int viewSpace = 15;
    int begainX = 4;
    for (int i = 0; i < 9; i++) {
        btFunction = [FWButton buttonWithType:UIButtonTypeCustom];
        
        [btFunction setTitle:[textArr objectAtIndex:i] forState:UIControlStateNormal];
        [btFunction setImage:[UIImage imageNamed:[normalImageViewImageArr objectAtIndex:i]] forState:UIControlStateNormal];
        [btFunction setImage:[UIImage imageNamed:[hightlightedImageViewImageArr objectAtIndex:i]] forState:UIControlStateHighlighted];
        [btFunction setBackgroundColor:[UIColor clearColor]];
        [btFunction.titleLabel setFont:[UIFont systemFontOfSize:10]];
        btFunction.frame = CGRectMake(begainX + (kWidth + viewSpace) * i, 3.5, kWidth, kHeight - 7);
        highlightedTextColor = [UIColor colorWithRed:19 / 255.0 green:105 / 255.0 blue:240 / 255.0 alpha:1.0];
        btFunction.highlightedTextColor = highlightedTextColor;
        btFunction.topPading = 3;
        [btFunction addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btFunction];
    }
}

- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *text = [btn titleLabel].text;
    
    if ([text isEqualToString:@"智能优化"])
    {
        FWAutoBeautyViewController *vc = [[FWAutoBeautyViewController alloc] initWithImage:self.image];
        
        [self presentViewController:vc animated:YES completion:^{
        }];
    }
    else if ([text isEqualToString:@"增强"])
    {
        FWColorListViewController *vc = [[FWColorListViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:^{
        }];
    }
    else if ([text isEqualToString:@"编辑"])
    {
        FWEditViewController *vc = [[FWEditViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:^{
        }];
        
    }
    else if ([text isEqualToString:@"特效"])
    {
        FWFiltersViewController *vc = [[FWFiltersViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:^{
        }];
    }
    else if ([text isEqualToString:@"边框"])
    {
        FWBorderViewController *vc = [[FWBorderViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:^{
        }];
    }
    else if ([text isEqualToString:@"背景虚化"])
    {
        FWBlurViewController *vc = [[FWBlurViewController alloc] initWithImage:self.image];
        [self presentViewController:vc animated:YES completion:^{
        }];
    }
}

@end
