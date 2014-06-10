//
//  FWWebViewController.h
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/20.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QVToolBarScrollStatusInit = 0,
    QVToolBarScrollStatusAnimation ,
}QVToolBarScrollStatus;

@interface FWWebViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate, UIActionSheetDelegate> {
    id delegate;
    UIWebView *wv;
    UIToolbar *toolBar;
    
    UIBarButtonItem *refreshBtn;
    UIBarButtonItem *stopBtn;
    UIBarButtonItem *nextBtn;
    UIBarButtonItem *backBtn;
    UIBarButtonItem *actionBtn;
    
}

@property (nonatomic) BOOL toolBarScrollStatus;
@property (nonatomic) CGFloat beginScrollOffsetY;
@property (nonatomic, retain) id delegate;

@end
