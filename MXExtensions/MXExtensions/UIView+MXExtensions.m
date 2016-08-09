//
//  UIView+MXExtensions.m
//  MXExtensions
//
//  Created by 韦纯航 on 15/12/5.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import "UIView+MXExtensions.h"

#ifndef NSFoundationVersionNumber_iOS_7_1
    #define NSFoundationVersionNumber_iOS_7_1 1047.25
#endif

@implementation UIView (MXExtensions)

#pragma mark - CGRect

/**
 *  设置新x坐标
 *
 *  @param x x坐标值
 */
- (void)setMx_x:(CGFloat)mx_x
{
    CGRect frame = self.frame;
    frame.origin.x = mx_x;
    [self setFrame:frame];
}

/**
 *  设置新y坐标
 *
 *  @param y y坐标值
 */
- (void)setMx_y:(CGFloat)mx_y
{
    CGRect frame = self.frame;
    frame.origin.y = mx_y;
    [self setFrame:frame];
}

/**
 *  设置新宽尺寸
 *
 *  @param width 宽尺寸值
 */
- (void)setMx_width:(CGFloat)mx_width
{
    CGRect frame = self.frame;
    frame.size.width = mx_width;
    [self setFrame:frame];
}

/**
 *  设置新高尺寸
 *
 *  @param height 高尺寸值
 */
- (void)setMx_height:(CGFloat)mx_height
{
    CGRect frame = self.frame;
    frame.size.height = mx_height;
    [self setFrame:frame];
}

/**
 *  设置新尺寸
 *
 *  @param size 尺寸值
 */
- (void)setMx_size:(CGSize)mx_size
{
    CGRect frame = self.frame;
    frame.size = mx_size;
    [self setFrame:frame];
}

/**
 *  设置新坐标
 *
 *  @param origin 坐标值
 */
- (void)setMx_origin:(CGPoint)mx_origin
{
    CGRect frame = self.frame;
    frame.origin = mx_origin;
    [self setFrame:frame];
}

/**
 *  获取x坐标
 */
- (CGFloat)mx_x
{
    return CGRectGetMinX(self.frame);
}

/**
 *  获取y坐标
 */
- (CGFloat)mx_y
{
    return CGRectGetMinY(self.frame);
}

/**
 *  获取宽度值
 */
- (CGFloat)mx_width
{
    return CGRectGetWidth(self.frame);
}

/**
 *  获取高度值
 */
- (CGFloat)mx_height
{
    return CGRectGetHeight(self.frame);
}

/**
 *  获取尺寸
 */
- (CGSize)mx_size
{
    return self.frame.size;
}

/**
 *  获取坐标
 */
- (CGPoint)mx_origin
{
    return self.frame.origin;
}

/**
 *  获取最右边x坐标
 */
- (CGFloat)x_max
{
    return CGRectGetMaxX(self.frame);
}

/**
 *  获取最下边y坐标
 */
- (CGFloat)y_max
{
    return CGRectGetMaxY(self.frame);
}

#pragma mark - Radius & Border

/**
 *  使view变成圆角样式
 *  @param aRadius 圆角值
 */
- (void)mx_changeToRoundWithRadius:(CGFloat)aRadius
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:aRadius];
}

/**
 *  给view加上边框，可设定边框宽度和颜色
 *  @param aBorder 边框宽度
 *  @param aColor  边框颜色
 */
- (void)mx_changeBorder:(CGFloat)aBorder withColor:(UIColor *)aColor
{
    CGColorRef aColorRef = [aColor CGColor];
    [self.layer setBorderWidth:aBorder];
    [self.layer setBorderColor:aColorRef];
}

#pragma mark - Other

/**
 *  获取view上的第一响应者（textField、textView等）
 *
 *  @return 第一响应者
 */
- (UIView *)mx_firstResponder
{
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        id responder = [subView mx_firstResponder];
        if (responder) return responder;
    }
    
    return nil;
}

static const UIViewAutoresizing kAutoresizingMaskWH = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

/**
 *  设置view的autoresizingMask为W+H（比较常用）
 *  UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight
 */
- (void)mx_setAutoresizingMaskWH
{
    if ([self respondsToSelector:@selector(setAutoresizingMask:)]) {
        [self setAutoresizingMask:kAutoresizingMaskWH];
    }
}

#pragma mark - UITableView & UITableViewCell

/**
 *  调整UITableview分隔线15像素的偏移
 *  兼容iOS 7以上
 */
- (void)mx_setSeparatorInsetZero
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        if ([self isKindOfClass:[UITableView class]]) {
            [(UITableView *)self setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 *  隐藏没有数据的Cell（仅对UITableViewStylePlain有效）
 */
- (void)mx_setExtraCellLineHidden
{
    if (![self isKindOfClass:[UITableView class]]) {
        return;
    }
    
    UITableViewStyle style = [[self valueForKey:@"style"] integerValue];
    if (style != UITableViewStylePlain) {
        return;
    }
    
    if ([self respondsToSelector:@selector(setTableFooterView:)]) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [(UITableView *)self setTableFooterView:view];
    }
}

/**
 *  Cell使用自动布局兼容iOS 7
 */
- (void)mx_adjustAutoresizingForAutoLayout
{
    if (![self isKindOfClass:[UITableViewCell class]]) {
        return;
    }
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) {
        UIView *contentView = [self valueForKey:@"contentView"];
        contentView.frame = self.bounds;
        contentView.autoresizingMask = kAutoresizingMaskWH;
    }
}

#pragma mark - NSLayoutConstraint

- (NSLayoutConstraint *)constraint:(NSLayoutAttribute)a1 cEqualTo:(CGFloat)constant
{
    return [self constraint:a1 equalTo:nil c:constant];
}

- (NSLayoutConstraint *)constraint:(NSLayoutAttribute)a1 equalTo:(UIView *)view
{
    return [self constraint:a1 equalTo:view c:0.0];
}

- (NSLayoutConstraint *)constraint:(NSLayoutAttribute)a1 equalTo:(UIView *)view a:(NSLayoutAttribute)a2
{
    return [self constraint:a1 equalTo:view a:a2 c:0.0];
}

- (NSLayoutConstraint *)constraint:(NSLayoutAttribute)a1 equalTo:(UIView *)view c:(CGFloat)constant
{
    NSLayoutAttribute a2 = view ? a1 : NSLayoutAttributeNotAnAttribute;
    return [self constraint:a1 equalTo:view a:a2 c:constant];
}

- (NSLayoutConstraint *)constraint:(NSLayoutAttribute)a1 equalTo:(UIView *)view a:(NSLayoutAttribute)a2 c:(CGFloat)constant
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:a1 relatedBy:NSLayoutRelationEqual toItem:view attribute:a2 multiplier:1.0 constant:constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

@end
