//
//  FWChooseItemView.h
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/21.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@class FWItems;

@interface FWChooseItemView : MDCSwipeToChooseView

@property (nonatomic, strong, readonly) FWItems *items;

- (instancetype)initWithFrame:(CGRect)frame
                       items:(FWItems *)items
                      options:(MDCSwipeToChooseViewOptions *)options;






@end
