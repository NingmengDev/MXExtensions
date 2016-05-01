//
//  UIColor+MXExtensions.m
//  MXExtensions
//
//  Created by 韦纯航 on 15/11/28.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import "UIColor+MXExtensions.h"

@implementation UIColor (MXExtensions)

#pragma mark - Creating

/**
 *  随机颜色，透明度为1
 */
+ (UIColor *)mx_randomColor
{
    return [self mx_randomColorWithAlpha:1.0];
}

/**
 *  随机颜色，颜色值和透明度均是随机的
 */
+ (UIColor *)mx_randomWithAlphaColor
{
    CGFloat randomAlpha = arc4random() % 256 / 255.0;
    return [self mx_randomColorWithAlpha:randomAlpha];
}

/**
 *  随机颜色，指定透明度
 *
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_randomColorWithAlpha:(CGFloat)alpha
{
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/**
 *  根据16进制字符串(HTML颜色值)获取颜色
 *  比如：#FF9900、0XFF9900等，不区分大小写
 *  默认透明度为1.0
 */
+ (UIColor *)mx_colorWithHex:(NSString*)hex
{
    return [self mx_colorWithHex:hex alpha:1.0];
}

/**
 *  根据16进制字符串(HTML颜色值)获取颜色，并指定透明度
 *
 *  @param hex   HTML颜色值
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_colorWithHex:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return MX_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return MX_VOID_COLOR;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    
    return [self mx_colorWithR:red G:green B:blue alpha:alpha];
}

/**
 *  RGB颜色
 *
 *  @param red   红
 *  @param green 绿
 *  @param blue  蓝
 */
+ (UIColor *)mx_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue
{
    return [self mx_colorWithR:red G:green B:blue alpha:1.0];
}

/**
 *  RGB颜色，指定透明度
 *
 *  @param alpha 指定的透明度
 */
+ (UIColor *)mx_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

/**
 *  渐变颜色
 *  默认渐变方向为从上往下渐变
 */
+ (UIColor *)mx_gradientColorFrom:(UIColor *)color1 to:(UIColor *)color2 value:(CGFloat)value
{
    return [self mx_gradientColorFrom:color1 to:color2 value:value orientation:MXColorGradientOrientationTopToBottom];
}

/**
 *  随机渐变颜色，并指定渐变方向
 */
+ (UIColor *)mx_randomGradientColorWithValue:(CGFloat)value orientation:(MXColorGradientOrientation)orientation
{
    UIColor *color1 = [[self class] mx_randomColor];
    UIColor *color2 = [[self class] mx_randomColor];
    return [self mx_gradientColorFrom:color1 to:color2 value:value orientation:orientation];
}

/**
 *  渐变颜色，并指定渐变方向
 *
 *  @param color1      起始颜色
 *  @param color2      终止颜色
 *  @param value       渐变范围值
 *  @param orientation 渐变方向
 */
+ (UIColor *)mx_gradientColorFrom:(UIColor *)color1 to:(UIColor *)color2 value:(CGFloat)value orientation:(MXColorGradientOrientation)orientation
{
    CGSize size = CGSizeZero;
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    if (orientation == MXColorGradientOrientationTopToBottom) {
        size = CGSizeMake(1.0, value);
        endPoint = CGPointMake(0.0, size.height);
    }
    else {
        size = CGSizeMake(value, 1.0);
        endPoint = CGPointMake(size.width, 0.0);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)color1.CGColor, (id)color2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

#pragma mark - Parsing

/**
 *  获取RGB颜色的R值
 */
- (CGFloat)mx_red
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be an RGB color to use -red");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

/**
 *  获取RGB颜色的G值
 */
- (CGFloat)mx_green
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be an RGB color to use -green");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    
    if (self.mx_colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    
    return c[1];
}

/**
 *  获取RGB颜色的B值
 */
- (CGFloat)mx_blue
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be an RGB color to use -blue");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.mx_colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    
    return c[2];
}

/**
 *  获取单色颜色的white值
 */
- (CGFloat)mx_white
{
    NSAssert(self.mx_colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

/**
 *  获取RGB颜色的透明度
 */
- (CGFloat)mx_alpha
{
    return CGColorGetAlpha(self.CGColor);
}

/**
 *  获取颜色的字符串描述
 *  如：
 */
- (NSString *)mx_colorString
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be an RGB color to use -colorString");
    
    NSString *result = nil;
    
    switch (self.mx_colorSpaceModel) {
        case kCGColorSpaceModelRGB: {
            result = [NSString stringWithFormat:@"{%0.0f, %0.0f, %0.0f, %0.2f}", self.mx_red * 255.0, self.mx_green * 255.0, self.mx_blue * 255.0, self.mx_alpha];
        }
            break;
            
        case kCGColorSpaceModelMonochrome: {
            result = [NSString stringWithFormat:@"{%0.0f, %0.2f}", self.mx_white * 255.0, self.mx_alpha];
        }
            break;
            
        default: {
            result = @"Can't parse the color.";
        }
            break;
    }
    
    return result;
}

/**
 *  获取颜色的16进制字符串
 */
- (NSString *)mx_hexString
{
    return [NSString stringWithFormat:@"%0.6x", (unsigned int)self.mx_hexRGB];
}

/**
 *  获取颜色的16进制字符串，带透明度值
 */
- (NSString *)mx_hexStringWithAlpha
{
    return [NSString stringWithFormat:@"%0.8x", (unsigned int)self.mx_hexRGBA];
}

#pragma mark - Private

- (CGColorSpaceModel)mx_colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)mx_canProvideRGBComponents
{
    switch (self.mx_colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
            
        default:
            return NO;
    }
}

- (UInt32)mx_hexRGB
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be a RGB color to use hexRGB");
    
    CGFloat r, g, b, a;
    
    if (![self red:&r green:&g blue:&b alpha:&a]) {
        return 0;
    }
    
    r = fminf(fmaxf(r, 0.0f), 1.0f);
    g = fminf(fmaxf(g, 0.0f), 1.0f);
    b = fminf(fmaxf(b, 0.0f), 1.0f);
    
    return (UInt32) ((((int)roundf(r * 255)) << 16) | (((int)roundf(g * 255)) << 8) | (((int)roundf(b * 255))));
}

- (UInt32)mx_hexRGBA
{
    NSAssert(self.mx_canProvideRGBComponents, @"Must be a RGBA color to use hexRGBA");
    
    CGFloat r, g, b, a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = fminf(fmaxf(self.mx_red, 0.0f), 1.0f);
    g = fminf(fmaxf(self.mx_green, 0.0f), 1.0f);
    b = fminf(fmaxf(self.mx_blue, 0.0f), 1.0f);
    a = fminf(fmaxf(self.mx_alpha, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 24) | (((int)roundf(g * 255)) << 16) | (((int)roundf(b * 255)) << 8) | (((int)roundf(a * 255)));
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r, g, b, a;
    
    switch (self.mx_colorSpaceModel) {
        case kCGColorSpaceModelMonochrome: {
            r = g = b = components[0];
            a = components[1];
        }
            break;
            
        case kCGColorSpaceModelRGB: {
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
        }
            break;
            
        default:	// We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

@end
