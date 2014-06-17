//
//  FWViewController.h
//  SkipOrLikeSample
//
//  Created by Fumitaka Watanabe on 2014/05/13.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWChooseItemView.h"
#import "FWDetailsViewController.h"

@interface FWViewController : UIViewController <MDCSwipeToChooseDelegate> {
    NSString *itemName;
    UIImage *itemImage;
    NSString *itemPrice;
    
    NSMutableArray *itemsArray;
    
    FWChooseItemView *cardView;

}

- (void)likeFrontCardView;

@property (nonatomic, strong) FWItems *currentItem;
@property (nonatomic, strong) FWChooseItemView *frontCardView;
@property (nonatomic, strong) FWChooseItemView *backCardView;

@property (nonatomic,retain) UITapGestureRecognizer *tapGesturerRecognizer;


@end
