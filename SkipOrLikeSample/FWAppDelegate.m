//
//  FWAppDelegate.m
//  SkipOrLikeSample
//
//  Created by Fumitaka Watanabe on 2014/05/13.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <Parse/Parse.h>
#import "FWAppDelegate.h"
#import "FWViewController.h"



@implementation FWAppDelegate {
    UINavigationController *navigationController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[FWViewController new]];
    
    return YES;
}


@end
