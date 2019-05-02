//
//  FWBlurViewController.h
//  FWMeituApp
//
//  Created by hzkmn on 16/1/14.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FWEffectBar.h"

@interface FWBlurViewController : UIViewController <FWEffectBarDelegate>

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;

@end
