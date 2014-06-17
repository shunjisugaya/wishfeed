//
//  FWRegisterViewController.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/06/17.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWRegisterViewController.h"
#import "FWStartViewController.h"


@interface FWRegisterViewController ()

@end

@implementation FWRegisterViewController


# pragma mark - UIViewController Overrides
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    [self registAsFacebook];
    
    [self registAsBasicUser];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    // 前のページに戻るボタンを作成
    UIBarButtonItem *arrowButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"]
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(backToView:)];
    
    
    self.navigationItem.leftBarButtonItem = arrowButton;
    arrowButton.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    UIBarButtonItem *skipButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"skip_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(skipMethod:)];
    // ここはシェアボタン
    self.navigationItem.rightBarButtonItem = skipButton;
    skipButton.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];

   
    
}

# pragma mark - View Construction

- (void)registAsFacebook {
    UIImage *img = [UIImage imageNamed:@"FB_register"];
    self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookBtn setImage:img forState:UIControlStateNormal];
    [self.facebookBtn sizeToFit];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    if (frame.size.height == 480) {
        // 4 and 4S
        frame = CGRectMake(15, 75, img.size.width, img.size.height);
    }else {
        // 5, 5S, and 5C
        frame = CGRectMake(15, 75, img.size.width, img.size.height);
    }
    self.facebookBtn.frame = frame;
    [self.facebookBtn addTarget:self
                         action:@selector(registByFacebook:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.facebookBtn];

    
}

- (void)registAsBasicUser {
    
    UIImage *img = [UIImage imageNamed:@"register"];
    self.registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registBtn setImage:img forState:UIControlStateNormal];
    [self.registBtn sizeToFit];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    if (frame.size.height == 480) {
        // 4 and 4S
        frame = CGRectMake(15, 250, img.size.width, img.size.height);
    }else {
        // 5, 5S, and 5C
        frame = CGRectMake(15, 300, img.size.width, img.size.height);
    }
    self.registBtn.frame = frame;
    [self.registBtn addTarget:self
                         action:@selector(registByBasic:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.registBtn];

    
    
}

# pragma mark - Control Events

- (void)registByFacebook:(id)sender {
    NSLog(@"Facebook registration has been tried again.");
    
    
}

- (void)registByBasic:(id)sender {
    NSLog(@"Basic registration has been tried.");
    
}

- (void)backToView:(id)sender {
    
      [self.navigationController popViewControllerAnimated:YES];
   
        self.navigationController.navigationBarHidden = YES;
    
    
}

- (void)skipMethod:(id)sender {
    
    NSLog(@"skip registration.");
    
}



@end
