//
//  FWImageLabelView.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/21.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWImageLabelView.h"

@interface FWImageLabelView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;



@end

@implementation FWImageLabelView

#pragma mark - Object Lifecycle

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)text {
    self = [super initWithFrame:frame];
    if (self) {
        [self constructImageView:image];
        [self constructLabel:text];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)constructImageView:(UIImage *)image {
    CGRect bottomFrame = [[UIScreen mainScreen] bounds];
    if(bottomFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        bottomFrame = CGRectMake(35,85,250,230);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        bottomFrame =  CGRectMake(35,85,250,300);
    }
    self.imageView = [[UIImageView alloc] initWithFrame:bottomFrame];
    self.imageView.image = image;
    [self addSubview:self.imageView];
}

- (void)constructLabel:(NSString *)text {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    if(frame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
       frame = CGRectMake(35,85,250,280);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        frame =  CGRectMake(35,85,250,350);
    }

    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.text = text;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
}



@end
