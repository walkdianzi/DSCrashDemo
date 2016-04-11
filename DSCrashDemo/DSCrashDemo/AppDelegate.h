//
//  AppDelegate.h
//  DSCrashDemo
//
//  Created by dasheng on 16/4/11.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *rooViewController;
@property (strong, nonatomic) UINavigationController *navgationController;

@end

