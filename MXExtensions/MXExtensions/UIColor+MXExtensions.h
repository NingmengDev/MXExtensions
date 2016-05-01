//
//  UIColor+MXExtensions.h
//  MXExtensions
//
//  Created by 韦纯航 on 15/11/28.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MX_VOID_COLOR [UIColor clearColor]

#define MXColorFromRGB(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

#define MXColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

#define MXColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define MXColorFromHexRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

typedef NS_ENUM(NSInteger, MXColorGradientOrientation)
{
    MXColorGradientOrientationTopToBottom = 0, //上往下
    MXColorGradientOrientationLeftToRight = 1  //左往右
};

@interface UIColor (MXExtensions)

#pragma mark - Creating

/**
 *  随机颜色，透明度为1.0
 */
+ (UIColor *)mx_randomColor;

/**
 *  随机颜色，颜色值和透明度均是随机的
 */
+ (UIColor *)mx_randomWithAlphaColor;

/**
 *  随机颜色，指定透明度
 *
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_randomColorWithAlpha:(CGFloat)alpha;

/**
 *  根据16进制字符串(HTML颜色值)获取颜色
 *  比如：#FF9900、0XFF9900等，不区分大小写
 *  默认透明度为1.0
 */
+ (UIColor *)mx_colorWithHex:(NSString*)hex;

/**
 *  根据16进制字符串(HTML颜色值)获取颜色，并指定透明度
 *
 *  @param hex   HTML颜色值
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_colorWithHex:(NSString*)hex alpha:(CGFloat)alpha;

/**
 *  RGB颜色
 *
 *  @param red   红
 *  @param green 绿
 *  @param blue  蓝
 */
+ (UIColor *)mx_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;

/**
 *  RGB颜色，指定透明度
 *
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 *  渐变颜色
 *  默认渐变方向为从上往下渐变
 */
+ (UIColor *)mx_gradientColorFrom:(UIColor *)color1 to:(UIColor *)color2 value:(CGFloat)value;

/**
 *  随机渐变颜色，并指定渐变方向
 */
+ (UIColor *)mx_randomGradientColorWithValue:(CGFloat)value orientation:(MXColorGradientOrientation)orientation;

/**
 *  渐变颜色，并指定渐变方向
 *
 *  @param color1      起始颜色
 *  @param color2      终止颜色
 *  @param value       渐变范围值
 *  @param orientation 渐变方向
 */
+ (UIColor *)mx_gradientColorFrom:(UIColor *)color1 to:(UIColor *)color2 value:(CGFloat)value orientation:(MXColorGradientOrientation)orientation;

#pragma mark - Parsing

/**
 *  获取RGB颜色的R值
 */
- (CGFloat)mx_red;

/**
 *  获取RGB颜色的G值
 */
- (CGFloat)mx_green;

/**
 *  获取RGB颜色的B值
 */
- (CGFloat)mx_blue;

/**
 *  获取单色颜色的white值
 */
- (CGFloat)mx_white;

/**
 *  获取颜色的透明度
 */
- (CGFloat)mx_alpha;

/**
 *  获取颜色的字符串描述
 *  如：{0, 175, 240, 1.00}
 */
- (NSString *)mx_colorString;

/**
 *  获取颜色的16进制字符串
 *  如：00aff0
 */
- (NSString *)mx_hexString;

/**
 *  获取颜色的16进制字符串，带透明度值
 *  如：00aff0ff
 */
- (NSString *)mx_hexStringWithAlpha;

@end
