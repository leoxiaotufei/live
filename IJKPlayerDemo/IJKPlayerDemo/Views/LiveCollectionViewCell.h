//
//  LiveCollectionViewCell.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/11.
//  Copyright © 2019 eirc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveModel, ALinUser;
@interface LiveCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) LiveModel *liveModel;
@property (nonatomic, strong) ALinUser *alinUser;
@end

