//
//  UIImage+MDF.h
//  RoyalClient
//
//  Created by Dick on 2017/10/9.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MDF)

+ (UIImage *)resizableImageWithName:(NSString *)imageName;

/**
 *  实现图片的缩小或者放大
 *
 *  @param size  大小范围
 *
 *  @return 新的图片
 */
- (UIImage*)scaleImageWithSize:(CGSize)size;

/**
 *  模糊图片
 *
 *  @return 模糊后的图片
 */
- (UIImage *)blurredImage;

/**
 *  根据坐标与大小裁剪图片
 *
 *  @param rect 裁剪范围
 *
 *  @return 裁剪后的图片
 */
- (UIImage *)clipWithRect:(CGRect)rect;

/**
 *  根据最大范围缩放图片，类似于css中的max-height与max-width
 *
 *  @param maxSize 最大范围
 *
 *  @return 缩放后的图片
 */
- (UIImage *)scaleWithMaxSize:(CGSize)maxSize;

/**
 *  根据缩放比例，缩放图片
 *
 *  @param scale 缩放比例
 *
 *  @return 缩放后的图片
 */
- (UIImage *)scaleWithScale:(CGFloat)scale;

//修改图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

// 通过颜色获取图片
+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)mdf_imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius;

+ (UIImage *)mdf_circularImageWithColor:(UIColor *)color
                                   size:(CGSize)size;
+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                    borderColor:(UIColor *)borderColor;
+ (UIImage *) mdf_imageWithColor:(UIColor *)color
                            size:(CGSize)size
                            text:(NSString *)text
                            font:(UIFont *)font
                       textColor:(UIColor *)textColor corderRadius:(CGFloat )cornerRadius;

- (UIImage *)mdf_croppedImage:(CGRect)bounds;
- (UIImage *)mdf_thumbnailImage:(NSInteger)thumbnailSize
              transparentBorder:(NSUInteger)borderSize
                   cornerRadius:(NSUInteger)cornerRadius
           interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImage:(CGSize)newSize
         interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                      bounds:(CGSize)bounds
                        interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImage:(CGSize)newSize
                    transform:(CGAffineTransform)transform
               drawTransposed:(BOOL)transpose
         interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)mdf_transformForOrientation:(CGSize)newSize;
- (UIImage*)mdf_fixOrientation;

@end
