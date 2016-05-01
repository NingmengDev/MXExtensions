//
//  NSString+MXExtensions.h
//  MXExtensions
//
//  Created by 韦纯航 on 15/11/28.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MXExtensions)

#pragma mark - Boolen Callback

/**
 *  判断字符串是否有效（或为空）
 */
- (BOOL)mx_isValid;

/**
 *  判断字符串中是否含有subString
 *  比如"ABCD"中包含有"BC"字符串，但不包含有"AC"字符串
 */
- (BOOL)mx_containsSubString:(NSString *)subString;

/**
 *  判断字符串是否只含有字母
 */
- (BOOL)mx_containsOnlyLetters;

/**
 *  判断字符串是否只含有数字
 */
- (BOOL)mx_containsOnlyNumbers;

/**
 *  判断字符串是否只含有数字和字母
 */
- (BOOL)mx_containsOnlyNumbersAndLetters;

/**
 *  判断是否为有效的邮箱
 */
- (BOOL)mx_isValidEmail;

/**
 *  判断是否为有效的url地址
 */
- (BOOL)mx_isValidURL;

/**
 *  判断是否为有效的手机号
 *  排除了10、11、12、19开头的情况
 */
- (BOOL)mx_isValidPhoneNumber;

/**
 *  判断字符串是否匹配指定的正则表达式
 *
 *  @param regex 指定的正则表达式
 */
- (BOOL)mx_isMatchesPredicate:(NSString *)regex;

#pragma mark - NSString Callback

/**
 *  去掉字符串中的空白字符
 */
- (NSString *)mx_removeWhiteSpaces;

/**
 *  给URL地址中的特殊字符进行编码
 *
 *  @return 编码后的ULR地址
 */
- (NSString *)mx_stringWithURLEncode;

/**
 *  获取当前设备UUID
 *  例如：E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 */
- (NSString *)mx_deviceUUIDString;

/**
 *  获取应用版本号
 */
+ (NSString *)mx_getApplicationVersion;

/**
 *  获取应用名称
 */
+ (NSString *)mx_getApplicationName;

/**
 *  将时间戳转换为字符串，并计算距离此时多久
 *  @param timeInterval 时间戳（秒）
 */
+ (NSString *)mx_timeStingWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 *  将Unicode编码的字符串转换为普通字符
 *  一般用于打印查看服务器返回的一些错误信息
 *  @param unicodeString Unicode编码的字符
 */
+ (NSString *)mx_replaceUnicode:(NSString *)unicodeString;

/**
 *  将字符串进行MD5加密
 */
- (NSString *)mx_MD5String;

/**
 *  获取UUID字符串，每个UUID字符串一个应用中是唯一的
 *  得到的结果例如：36lPjxiCiIVhmIIVKwQ37Ez4
 *  可用于文件名等
 */
+ (NSString *)mx_UUIDString;

#pragma mark - Number Callback

/**
 *  获取字符串中数字的个数
 */
- (NSUInteger)mx_countNumberOfWords;

/**
 *  获取文字个数（汉字、表情外的字符两个算一个字）
 */
- (NSUInteger)mx_countWords;

#pragma mark - CGRect Callback

/**
 *  获取单行文字的尺寸
 */
- (CGSize)mx_sizeWithFont:(UIFont *)font;

/**
 *  获取多行文字的高度
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param maxWidth    最大宽度
 *
 *  @return 文字高度
 */
- (CGFloat)mx_heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxWidth:(CGFloat)maxWidth;

/**
 *  获取多行文字的尺寸
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param maxSize     限定的最大范围
 *
 *  @return 文字尺寸
 */
- (CGSize)mx_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize;

#pragma mark - NSAttributedString Callback

/**
 *  根据字体获取富文本（默认字体颜色为黑色，行间距为0）
 *
 *  @param font 字体
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font;

/**
 *  根据行间距和字体获取富文本（默认字体颜色为黑色）
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

/**
 *  根据字体、字体颜色获取富文本
 *
 *  @param font      字体
 *  @param textColor 字体颜色
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;

/**
 *  根据文本对齐方式和字体获取富文本（默认字体颜色为黑色）
 *
 *  @param font      字体
 *  @param alignment 对齐方式
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font alignment:(NSTextAlignment)alignment;

/**
 *  根据字体、字体颜色、行间距获取富文本
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param textColor   文字颜色
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font
                                        lineSpacing:(CGFloat)lineSpacing
                                          textColor:(UIColor *)textColor;

/**
 *  根据行间距、字体、字体颜色、对齐方式获取富文本
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param textColor   字体颜色
 *  @param alignment   字体对齐方式
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font
                                        lineSpacing:(CGFloat)lineSpacing
                                          textColor:(UIColor *)textColor
                                          alignment:(NSTextAlignment)alignment;

@end
