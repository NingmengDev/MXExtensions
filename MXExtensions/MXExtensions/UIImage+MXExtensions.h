//
//  UIImage+MXExtensions.h
//  MXExtensions
//
//  Created by 韦纯航 on 15/12/5.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MXExtensions)

/**
 *  将颜色转换成图片
 */
+ (UIImage *)mx_imageFromColor:(UIColor *)color;

/**
 *  获取屏幕截图
 */
+ (UIImage *)mx_screenshot;

/**
 *  将图片缩小到某个尺寸，不保持宽高比
 *
 *  @param dstSize 目标尺寸
 */
- (UIImage *)mx_resizedImageToSize:(CGSize)dstSize;

/**
 *  将图片等比缩放到某个尺寸
 *
 *  @param boundingSize 目标尺寸
 *  @param scale        图片不够尺寸大时是否放大
 */
- (UIImage *)mx_resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

/**
 *  将图片的某个部位进行无损拉伸填充
 *
 *  @param capInsets 拉伸部位与原图的边距
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)mx_resizableWithCapInsets:(UIEdgeInsets)capInsets;

/**
 *  将图片缩放到某个尺寸，不保持宽高比
 *  当图片尺寸不适合目标尺寸时，将从原图中间位置向四周取目标尺寸的图片内容
 *
 *  @param dstSize dstSize 目标尺寸
 */
- (UIImage *)mx_scaleFitCenterToSize:(CGSize)dstSize;

/**
 *  从图片上的某个范围截取图片
 *
 *  @param bounds 截取范围
 */
- (UIImage *)mx_croppedImageWithBounds:(CGRect)bounds;

/**
 *  将图片裁剪成为圆形
 *
 *  @param size 目标图片尺寸
 */
- (UIImage *)mx_circleImageBaseSize:(CGSize)size;

/**
 *  将图片裁剪成为圆角
 *
 *  @param size   目标图片尺寸
 *  @param radius 圆角度
 */
- (UIImage *)mx_roundImageBaseSize:(CGSize)size withRadius:(CGFloat)radius;

/**
 *  修正图片显示方向
 */
- (UIImage *)mx_fixOrientation;

/**
 *  将图片加上模糊效果
 *
 *  @param blurRadius 模糊度（0.0 - 1.0）
 */
- (UIImage *)mx_blurImageWithBlurRadius:(CGFloat)blurRadius;

@end
