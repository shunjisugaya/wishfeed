//
//  FWChooseItemView.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/21.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWChooseItemView.h"
#import "FWImageLabelView.h"
#import "FWItems.h"


@interface FWChooseItemView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation FWChooseItemView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                       items:(FWItems *)items
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        _items = items;
        self.imageView.image = _items.image;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;
        
        [self constructInformationView];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)constructInformationView {
    
    CGRect bottomFrame = [[UIScreen mainScreen] bounds];
    if(bottomFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        bottomFrame = CGRectMake(2,253,280,20);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        bottomFrame = CGRectMake(2,300,280,20);
    }
    
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor whiteColor];
    _informationView.clipsToBounds = YES;
    _informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin;
    
        
    [self addSubview:_informationView];
    
    [self constructNameLabel];
   
}

- (void)constructNameLabel {
    
    CGRect frame = CGRectMake(10,0,249,20);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:13];
    _nameLabel.text = [NSString stringWithFormat:@"%@       ￥%@", _items.name, _items.price];
    [_informationView addSubview:_nameLabel];
    
}



@end
