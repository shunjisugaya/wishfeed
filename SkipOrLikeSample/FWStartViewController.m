//
//  FWStartViewController.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/06/17.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWStartViewController.h"

@interface FWStartViewController ()

@end

@implementation FWStartViewController


# pragma mark - UIViewController Overrides
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
   
    
    [self backgroundImage];
    [self registrationForBeginner];
    [self registrationForFacebook];
    [self loginForAlreadyExists];

    
}


# pragma mark - View Construction
- (void)backgroundImage {
    
    UIImage *backgroundImage = [UIImage imageNamed:@"loading"];
    // self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    UIImageView *view = [[UIImageView alloc] initWithImage:backgroundImage];
    
    [self.view addSubview:view];

}

- (void)registrationForBeginner {
    
    UIImage *img = [UIImage imageNamed:@"first"];
    self.beginnerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beginnerBtn setImage:img forState:UIControlStateNormal];
    [self.beginnerBtn sizeToFit];
    CGRect frame = [[UIScreen mainScreen] bounds];
    if(frame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        frame = CGRectMake(15, 300, img.size.width, img.size.height);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        frame = CGRectMake(15, 350, img.size.width, img.size.height);
    }
    
    self.beginnerBtn.frame = frame;
    [self.beginnerBtn addTarget:self
                         action:@selector(registForTheFirstTime:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.beginnerBtn];
    
}

- (void)registrationForFacebook {
    
    UIImage *img = [UIImage imageNamed:@"facebook"];
    self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookBtn setImage:img forState:UIControlStateNormal];
    [self.facebookBtn sizeToFit];
    CGRect frame = [[UIScreen mainScreen] bounds];
    if (frame.size.height == 480) {
        // 4 and 4S
        frame = CGRectMake(15, 360, img.size.width, img.size.height);
    }else {
        // 5, 5S, and 5C
        frame = CGRectMake(15, 410, img.size.width, img.size.height);
    }
    self.facebookBtn.frame = frame;
    [self.facebookBtn addTarget:self
                         action:@selector(registByFacebook:)
               forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.facebookBtn];
    
    
}

- (void)loginForAlreadyExists {
    
    self.basicLoginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.basicLoginBtn setTitle:@"アカウントを既にお持ちの方" forState:UIControlStateNormal];
    self.basicLoginBtn.titleLabel.font = [UIFont fontWithName:@"AxisStd-Regular" size:15];
    self.basicLoginBtn.tintColor = [UIColor darkGrayColor];
    CGRect frame = [[UIScreen mainScreen] bounds];
    if (frame.size.height == 480) {
        // 4 and 4S
        frame = CGRectMake(frame.origin.x + 60, 435, 200, 20);
    } else {
        frame = CGRectMake(frame.origin.x + 60, 530, 200, 20);
    }
    
    self.basicLoginBtn.frame = frame;
    [self.basicLoginBtn addTarget:self
                           action:@selector(alreadyExists:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.basicLoginBtn];
    
    
    
    
}

# pragma mark - Control Events

- (void)registForTheFirstTime:(id)sender {
    
    NSLog(@"You press forward the registration screen.");
    
    
    FWRegisterViewController *view = [[FWRegisterViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (void)registByFacebook:(id)sender {
    
}


- (void)alreadyExists:(id)sender {
    
}

@end
