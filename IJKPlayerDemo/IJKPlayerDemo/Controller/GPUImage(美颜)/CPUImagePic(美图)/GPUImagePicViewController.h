//
//  GPUImagePicViewController.h
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "BaseViewController.h"
#import "FWBeautyViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPUImagePicViewController : BaseViewController<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    UIImagePickerController *imagePicker;
    UIButton *btnArrow;
    FWBeautyViewController *beautyVC;

}
@property (nonatomic ,strong) UIScrollView *scrolleView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

NS_ASSUME_NONNULL_END
