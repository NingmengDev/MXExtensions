//
//  NSString+MXExtensions.m
//  MXExtensions
//
//  Created by 韦纯航 on 15/11/28.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import "NSString+MXExtensions.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MXExtensions)

#pragma mark - Boolen Callback

/**
 *  判断是否为有效的String
 */
- (BOOL)mx_isValid
{
    return ([[self mx_removeWhiteSpaces] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO : YES;
}

/**
 *  判断字符串中是否含有subString
 *  比如"ABCD"中包含有"BC"字符串，但不包含有"AC"字符串
 */
- (BOOL)mx_containsSubString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

/**
 *  判断字符串是否只含有字母
 */
- (BOOL)mx_containsOnlyLetters
{
    NSString *regex = @"^[A-Za-z]+$";
    return [self mx_isMatchesPredicate:regex];
}

/**
 *  判断字符串是否只含有数字
 */
- (BOOL)mx_containsOnlyNumbers
{
    NSString *regex = @"^[0-9]+$";
    return [self mx_isMatchesPredicate:regex];
}

/**
 *  判断字符串是否只含有数字和字母
 */
- (BOOL)mx_containsOnlyNumbersAndLetters
{
    NSString *regex = @"^[A-Za-z0-9]+$";
    return [self mx_isMatchesPredicate:regex];
}

/**
 *  判断是否为有效的邮箱
 */
- (BOOL)mx_isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self mx_isMatchesPredicate:emailRegex];
}

/**
 *  判断是否为有效的url地址
 */
- (BOOL)mx_isValidURL
{
    NSString *ulrRegex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    return [self mx_isMatchesPredicate:ulrRegex];
}

/**
 *  判断是否为有效的手机号
 */
- (BOOL)mx_isValidPhoneNumber
{
    NSString *phoneNumberRegex = @"^[1][3-8]\\d{9}$";
    return [self mx_isMatchesPredicate:phoneNumberRegex];
}

/**
 *  判断字符串是否匹配指定的正则表达式
 *
 *  @param regex 指定的正则表达式
 */
- (BOOL)mx_isMatchesPredicate:(NSString *)regex
{
    if ([self length] == 0) return NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark - NSString Callback

/**
 *  去掉字符串中的空白字符
 */
- (NSString *)mx_removeWhiteSpaces
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

/**
 *  给URL地址中的特殊字符进行编码
 *
 *  @return 编码后的ULR地址
 */
- (NSString *)mx_stringWithURLEncode
{
    NSString *characterSet = @"!$&'()*+,-./:;=?@_~%#[]";
    NSCharacterSet *allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:characterSet];
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];  
}

/**
 *  获取当前设备UUID
 *  例如：E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 */
- (NSString *)mx_deviceUUIDString
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

/**
 *  获取应用版本号
 */
+ (NSString *)mx_getApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = info[@"CFBundleShortVersionString"];
    return version;
}

/**
 *  获取应用名称
 */
+ (NSString *)mx_getApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = info[@"CFBundleDisplayName"];
    return name;
}

/**
 *  将时间戳转换为字符串，并计算距离此时多久
 *  @param timeInterval 时间戳（精确到毫秒）
 */
+ (NSString *)mx_timeStingWithTimeInterval:(NSTimeInterval)timeInterval
{
    @try {
        static NSDateFormatter *dateFormatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone systemTimeZone];
            dateFormatter.locale = [NSLocale autoupdatingCurrentLocale];
        });

        // 取当前时间与需计算时间的时间间隔
        NSDate *nowDate = [NSDate date];
        NSDate *thatDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        long interval = (long)[nowDate timeIntervalSinceDate:thatDate];
        
        // 把间隔的秒数折算成天数和小时数
        NSString *dateString = @"";
        
        if (interval <= 60) {  // 1分钟以内
            dateString = @"刚刚";
        }
        else if (interval <= 60 * 60 * 24) {  // 在两天内的
            dateFormatter.dateFormat = @"YYYY/MM/dd";
            NSString *that_yMd = [dateFormatter stringFromDate:thatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            dateFormatter.dateFormat = @"HH:mm";
            dateString = [dateFormatter stringFromDate:thatDate];
            
            if ([that_yMd isEqualToString:now_yMd]) { // 在同一天
                if (interval > 60 * 60) {  // 一个小时以上
                    dateString = [NSString stringWithFormat:@"今天 %@", dateString];
                }
            }
            else { // 昨天
                dateString = [NSString stringWithFormat:@"昨天 %@", dateString];
            }
        }
        else {
            dateFormatter.dateFormat = @"yyyy";
            NSString *thatYear = [dateFormatter stringFromDate:thatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([thatYear isEqualToString:nowYear]) { // 在同一年
                dateFormatter.dateFormat = @"MM月dd日 HH:mm";
            }
            else { // 不在同一年
                dateFormatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
            }
            dateString = [dateFormatter stringFromDate:thatDate];
        }
        
        return dateString;
    }
    @catch (NSException *exception) {
        return @"未知时间";
    }
}

/**
 *  将Unicode编码的字符串转换为普通字符
 *  一般用于打印查看服务器返回的一些错误信息
 *  @param unicodeString Unicode编码的字符
 */
+ (NSString *)mx_replaceUnicode:(NSString *)unicodeString
{
    NSString *replaceString = [unicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    replaceString = [replaceString stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    replaceString = [[@"\""stringByAppendingString:replaceString] stringByAppendingString:@"\""];
    NSData *data = [replaceString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *returnString = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnString stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

/**
 *  将字符串进行MD5加密
 */
- (NSString *)mx_MD5String
{
    if (self.length == 0) {
        return nil;
    }
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]] lowercaseString];
}

/**
 *  获取UUID字符串，每个UUID字符串一个应用中是唯一的
 *  得到的结果例如：36lPjxiCiIVhmIIVKwQ37Ez4
 *  可用于文件名等
 */
+ (NSString *)mx_UUIDString
{
    NSString *chars = @"abcdefghijklmnopgrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    assert(chars.length == 62);
    u_int32_t len = (u_int32_t)chars.length;
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < 24; i ++) {
        int p = arc4random_uniform(len);
        NSRange range = NSMakeRange(p, 1);
        [result appendString:[chars substringWithRange:range]];
    }
    return result;
}

#pragma mark - Number Callback

/**
 * 获取字符串中数字的个数
 */
- (NSUInteger)mx_countNumberOfWords
{
    if (self.length == 0) {
        return 0;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet:whiteSpace intoString: nil]) {
        count ++;
    }
    
    return count;
}

/**
 *  获取文字个数（汉字、表情外的字符两个算一个字）
 */
- (NSUInteger)mx_countWords
{
    if (self.length == 0) return 0;
    
    NSUInteger len = self.length;
    // 汉字字符集
    NSString *pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    NSUInteger total = len + numMatch;
    NSUInteger offset = (total % 2) ? 1 : 0;
    return (total / 2 + offset);
}

#pragma mark - CGRect Callback

/**
 *  获取单行文字的尺寸
 */
- (CGSize)mx_sizeWithFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize size = [self sizeWithAttributes:attributes];
    return (CGSize){ceil(size.width), ceil(size.height)};
}

/**
 *  获取多行文字的高度
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param maxWidth    最大宽度
 *
 *  @return 文字高度
 */
- (CGFloat)mx_heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = (CGSize){maxWidth, CGFLOAT_MAX};
    return [self mx_sizeWithFont:font lineSpacing:lineSpacing maxSize:maxSize].height;
}

/**
 *  获取多行文字的尺寸
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param maxSize     限定的最大范围
 *
 *  @return 文字尺寸
 */
- (CGSize)mx_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [self boundingRectWithSize:maxSize options:options attributes:attributes context:nil].size;
    
    return (CGSize){ceil(size.width), ceil(size.height)};
}

#pragma mark - NSAttributedString Callback

/**
 *  根据字体获取富文本（默认字体颜色为黑色，行间距为0）
 *
 *  @param font 字体
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font
{
    return [self mx_attributedStringWithFont:font textColor:[UIColor blackColor]];
}

/**
 *  根据行间距和字体获取富文本（默认字体颜色为黑色）
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    return [self mx_attributedStringWithFont:font lineSpacing:lineSpacing textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
}

/**
 *  根据字体、字体颜色获取富文本
 *
 *  @param font      字体
 *  @param textColor 字体颜色
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    return [self mx_attributedStringWithFont:font lineSpacing:0.0 textColor:textColor alignment:NSTextAlignmentLeft];
}

/**
 *  根据文本对齐方式和字体获取富文本（默认字体颜色为黑色）
 *
 *  @param font      字体
 *  @param alignment 对齐方式
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    return [self mx_attributedStringWithFont:font lineSpacing:0.0 textColor:[UIColor blackColor] alignment:alignment];
}

/**
 *  根据字体、字体颜色、行间距获取富文本
 *
 *  @param font        字体
 *  @param lineSpacing 行间距
 *  @param textColor   文字颜色
 *
 *  @return 富文本
 */
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing textColor:(UIColor *)textColor
{
    return [self mx_attributedStringWithFont:font lineSpacing:lineSpacing textColor:textColor alignment:NSTextAlignmentLeft];
}

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
- (NSAttributedString *)mx_attributedStringWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setAlignment:alignment];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:textColor forKey:NSForegroundColorAttributeName];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    return [[NSAttributedString alloc] initWithString:self attributes:attributes];
}

@end
