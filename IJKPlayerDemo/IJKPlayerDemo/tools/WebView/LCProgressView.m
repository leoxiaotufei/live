//
//  LCProgressView.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/5/2.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "LCProgressView.h"
@interface LCProgressView()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation LCProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor mdf_colourWithHexString:@"4cd964"].CGColor,
                                 (__bridge id)[UIColor mdf_colourWithHexString:@"4cd964"].CGColor,
                                 (__bridge id)[UIColor mdf_colourWithHexString:@"4cd964"].CGColor];
        _gradientLayer.locations  = @[@0.3,@0.7, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint   = CGPointMake(1.0, 0);
        _gradientLayer.frame      = CGRectMake(0, 0, KScreenWidth, self.frame.size.height);
        [self.layer addSublayer:_gradientLayer];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _gradientLayer.colors = @[(__bridge id)_lineColor.CGColor,
                              (__bridge id)_lineColor.CGColor,
                              (__bridge id)_lineColor.CGColor];
}

@end
