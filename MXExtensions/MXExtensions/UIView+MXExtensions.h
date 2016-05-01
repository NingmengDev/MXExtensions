//
//  UIView+MXExtensions.h
//  MXExtensions
//
//  Created by 韦纯航 on 15/12/5.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MXExtensions)

#pragma mark - CGRect

/**
 *  获取view的Frame相关值
 */
@property (assign, nonatomic) CGFloat mx_x;
@property (assign, nonatomic) CGFloat mx_y;
@property (assign, nonatomic) CGFloat mx_width;
@property (assign, nonatomic) CGFloat mx_height;
@property (assign, nonatomic) CGSize mx_size;
@property (assign, nonatomic) CGPoint mx_origin;
@property (readonly) CGFloat x_max;
@property (readonly) CGFloat y_max;

#pragma mark - Radius & Border

/**
 *  使view变成圆角样式
 *  @param aRadius 圆角值
 */
- (void)mx_changeToRoundWithRadius:(CGFloat)aRadius;

/**
 *  给view加上边框，可设定边框宽度和颜色
 *  @param aBorder 边框宽度
 *  @param aColor  边框颜色
 */
- (void)mx_changeBorder:(CGFloat)aBorder withColor:(UIColor *)aColor;

#pragma mark - Other

/**
 *  获取view上的第一响应者（textField、textView等）
 *
 *  @return 第一响应者
 */
- (UIView *)mx_firstResponder;

/**
 *  设置view的autoresizingMask为W+H（比较常用）
 */
- (void)mx_setAutoresizingMaskWH;

#pragma mark - UITableView & UITableViewCell

/**
 *  调整UITableview分隔线15像素的偏移
 *  兼容iOS 7以上
 */
- (void)mx_setSeparatorInsetZero;

/**
 *  隐藏没有数据的Cell（仅对UITableViewStylePlain有效）
 */
- (void)mx_setExtraCellLineHidden;

/**
 *  Cell使用自动布局兼容iOS 7
 */
- (void)mx_adjustAutoresizingForAutoLayout;

@end
