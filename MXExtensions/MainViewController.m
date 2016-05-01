//
//  MainViewController.m
//  MXExtensions
//
//  Created by 韦纯航 on 16/5/1.
//  Copyright © 2016年 韦纯航. All rights reserved.
//

#import "MainViewController.h"

#import "MXExtensions.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MXExtensions";
    
    /**
     *  UIColor+MXExtensions
     */
    self.view.backgroundColor = [UIColor mx_randomColor];
    
    /**
     *  UIView+MXExtensions
     */
    NSLog(@"self.view.width = %f", self.view.mx_width);
    
    /**
     *  NSString+MXExtensions
     */
    NSString *string = @"MXExtensions";
    if ([string mx_isValid]) {
        NSLog(@"字符串有效");
    }
    else {
        NSLog(@"字符串无效");
    }
    
    /**
     *  UIApplication+MXExtensions
     */
    [UIApplication mx_getActivityViewControllerAndNav:^(UIViewController *vc, UINavigationController *nav) {
        NSLog(@"vc = %@", NSStringFromClass(vc.class));
        NSLog(@"nav = %@", NSStringFromClass(nav.class));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /**
     *  UIImage+MXExtensions
     */
    UIImage *image = [UIImage mx_screenshot];
    NSLog(@"screenshot size = %@", NSStringFromCGSize(image.size));
}

@end
