//
//  FWAppDelegate.h
//  SkipOrLikeSample
//
//  Created by Fumitaka Watanabe on 2014/05/13.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWViewController.h"
#import "FWStartViewController.h"

@interface FWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FWStartViewController *startViewController;

@end
