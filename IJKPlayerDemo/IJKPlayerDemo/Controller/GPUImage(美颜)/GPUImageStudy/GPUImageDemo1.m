//
//  GPUImageDemo1.m
//  IJKPlayerDemo
//
//  Created by iMac on 2019/4/30.
//  Copyright © 2019 eirc. All rights reserved.
//

#import "GPUImageDemo1.h"
@interface GPUImageDemo1 ()
@property (nonatomic , strong) UIImageView* mImageView;
@end

@implementation GPUImageDemo1

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    self.mImageView = imageView;
    [self onCustom];
}

- (void)onCustom {
    GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    UIImage *image = [UIImage imageNamed:@"faceww"];
//    self.mImageView.image = image;
    if (image) {
        self.mImageView.image = [filter imageByFilteringImage:image];
    }
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
