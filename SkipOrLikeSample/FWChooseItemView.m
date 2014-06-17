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
@property (nonatomic, strong) UILabel *priceLabel;
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
    [self constructPriceLabel];
   
}

- (void)constructNameLabel {
    
    CGRect frame = CGRectMake(10,0,180,20);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:14];
    _nameLabel.text = [NSString stringWithFormat:@"%@", _items.name];
    [_informationView addSubview:_nameLabel];
    
}

- (void)constructPriceLabel {
    CGRect frame = CGRectMake(160, 0,100, 20);
    _priceLabel = [[UILabel alloc] initWithFrame:frame];
    _priceLabel.textColor = [UIColor darkGrayColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:14];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",_items.price];
    [_informationView addSubview:_priceLabel];
    
    
}


@end
