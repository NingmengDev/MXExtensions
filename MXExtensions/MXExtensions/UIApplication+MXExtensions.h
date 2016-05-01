//
//  UIApplication+MXExtensions.h
//  MXExtensions
//
//  Created by 韦纯航 on 15/12/25.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIApplicationMXExtensionsBlock)(UIViewController *vc, UINavigationController *nav);

@interface UIApplication (MXExtensions)

/**
 *  获取当前处于activity状态的ViewController
 *
 *  @return activity状态的ViewController
 */
+ (UIViewController *)mx_activityViewController;

/**
 *  获取当前处于activity状态的ViewController和其所在的导航栏
 *
 *  @param callback 回调
 */
+ (void)mx_getActivityViewControllerAndNav:(UIApplicationMXExtensionsBlock)callback;

@end
