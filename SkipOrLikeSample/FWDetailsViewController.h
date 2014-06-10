//
//  FWDetailsViewController.h
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/18.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWChooseItemView.h"


@interface FWDetailsViewController : UIViewController <UIScrollViewDelegate,MDCSwipeToChooseDelegate> {
    UIScrollView *scrollThis;
    UIPageControl *pageControl;
    
}
@property (nonatomic, strong) FWItems *items;
@property (nonatomic, strong) FWChooseItemView *frontCardView;
@property (nonatomic, strong) FWChooseItemView *backCardView;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *likebutton;
@property (nonatomic ,strong) UIImage *likeImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *linkLabel;



@end
