//
//  UIApplication+MXExtensions.m
//  MXExtensions
//
//  Created by 韦纯航 on 15/12/25.
//  Copyright © 2015年 韦纯航. All rights reserved.
//

#import "UIApplication+MXExtensions.h"

@implementation UIApplication (MXExtensions)

/**
 *  获取当前处于activity状态的ViewController
 *
 *  @return activity状态的ViewController
 */
+ (UIViewController *)mx_activityViewController
{
    UIViewController *result = nil;
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                topWindow = window;
                break;
            }
        }
    }
    
    UIView *frontView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = topWindow.rootViewController;
    
    return result;
}

/**
 *  获取当前处于activity状态的ViewController和其所在的导航栏
 *
 *  @param callback 回调
 */
+ (void)mx_getActivityViewControllerAndNav:(UIApplicationMXExtensionsBlock)callback
{
    UIViewController *activityViewController = [self mx_activityViewController];
    
    if ([activityViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)activityViewController;
        activityViewController = [tabBarController viewControllers][tabBarController.selectedIndex];
    }
    
    UINavigationController *nav = nil;
    UIViewController *vc = nil;
    if ([activityViewController isKindOfClass:[UINavigationController class]]) {
        nav = (UINavigationController *)activityViewController;
        vc = [nav topViewController];
    }
    else {
        vc = activityViewController;
        nav = activityViewController.navigationController;
    }
    
    if (callback) callback(vc, nav);
}

@end
