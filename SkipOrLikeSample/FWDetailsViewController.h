//
//  FWDetailsViewController.h
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/18.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

#import "FWChooseItemView.h"
#import "FWItems.h"
#import "FWWebViewController.h"



@interface FWDetailsViewController : UIViewController <MDCSwipeToChooseDelegate,
UIScrollViewDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate> {
   
    UIScrollView *scrollThis;
    UIPageControl *pageControl;
    
}

@property (nonatomic,retain) NSMutableArray *items;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *likebutton;
@property (nonatomic, strong) UIImage *likeImage;
@property (nonatomic, strong) UIImage *likeImagePushed;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *linkLabel;

@property  NSString *itemName;
@property UIImage *itemImage;
@property NSString *itemPrice;

@property  NSMutableArray *itemsArray;

@property FWChooseItemView *cardView;

@end
