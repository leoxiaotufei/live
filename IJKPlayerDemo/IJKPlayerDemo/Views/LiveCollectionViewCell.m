//
//  LiveCollectionViewCell.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/11.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "LiveCollectionViewCell.h"
#import "LiveModel.h"
#import "ALinUser.h"
@interface LiveCollectionViewCell()

@property (nonatomic, strong) UIImageView *cover;
@property (nonatomic, strong) UILabel *name;
@end

@implementation LiveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    [self addSubview:self.cover];
    [self addSubview:self.name];
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
}

- (void)setLiveModel:(LiveModel *)liveModel {
    _liveModel = liveModel;
    self.name.text = liveModel.data.live_info.name?:@"";
    if (!liveModel.data.live_info.creator.portrait || liveModel.data.live_info.creator.portrait.length <= 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:liveModel.data.live_info.creator.portrait];
    [self.cover sd_setImageWithURL:url placeholderImage:nil options:SDWebImageTransformAnimatedImage];
}

- (void)setAlinUser:(ALinUser *)alinUser {
    _alinUser = alinUser;
    self.name.text = alinUser.nickname?:@"";
    if (!alinUser.photo || alinUser.photo.length <= 0) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:alinUser.photo];
    [self.cover sd_setImageWithURL:url placeholderImage:nil options:SDWebImageTransformAnimatedImage];
}

- (UIImageView *)cover {
    if (!_cover) {
        _cover = [UIImageView new];
        _cover.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _cover;
}

- (UILabel *)name {
    if (!_name){
        _name = [UILabel new];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont systemFontOfSize:13];
    }
    return _name;
}

@end
