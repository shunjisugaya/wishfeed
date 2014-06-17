//
//  FWAppDelegate.m
//  SkipOrLikeSample
//
//  Created by Fumitaka Watanabe on 2014/05/13.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//


#import "FWAppDelegate.h"




@implementation FWAppDelegate {
    UINavigationController *navigationController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    /*
    FWStartViewController *viewController = [[FWStartViewController alloc] init];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBarHidden = YES;
     */
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[FWViewController new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
