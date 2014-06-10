//
//  FWDetailsViewController.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/18.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWDetailsViewController.h"
#import "FWViewController.h"
#import "FWItems.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "FWWebViewController.h"


@interface FWDetailsViewController ()
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;


@end

@implementation FWDetailsViewController


#pragma mark - UIViewController Overrides


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self constructView];
    [self constructLabel];

    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _toolBar.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    // 前のページに戻るボタンを作成
    UIBarButtonItem *arrowButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"]
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(backToView:)];
    
    self.navigationItem.leftBarButtonItem = arrowButton;
    arrowButton.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"]
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                 action:@selector(shareThis:)];
    // ここはシェアボタン
    self.navigationItem.rightBarButtonItem = shareButton;
    shareButton.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    
    // ナビゲーションのタイトルに「アイテム詳細」を挿入
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.textColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    title.text = @"アイテム詳細";
    title.font =[UIFont fontWithName:@"AxisStd-Light" size:15];
    [title sizeToFit];
    self.navigationItem.titleView = title;
    
    
}


#pragma mark - MDCSwipeToChooseDelegate Protocol Methods

// ユーザーがスワイプしきらずにキャンセルした場合
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You Couldn't Decide on %@.", self.items.name);
}

// ユーザーが完全にスワイプした場合〜
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    // MDCSwipeToChooseを使って、左にスワイプすると「SKIP」スタンプを表示,
    // あと、右は「LIKE」
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You Skipped %@.", self.items.name);
    } else {
        NSLog(@"You Liked %@.", self.items.name);
    }
}



#pragma mark - Internal Methods

- (void)setFrontCardView:(FWChooseItemView *)frontCardView {
    // Keep track of the person currently being chosen.
    // Quick and dirty, just for the purposes of this sample app.
    _frontCardView = frontCardView;
    self.items = frontCardView.items;
}

#pragma mark - view Construction

- (void)constructView {
    
    // スクロールできるようにしていくよ〜
    NSInteger pageSize = 4;
    
    scrollThis = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollThis.backgroundColor = [UIColor whiteColor];
    scrollThis.showsHorizontalScrollIndicator = NO;
    scrollThis.pagingEnabled = YES;
    scrollThis.delegate = self;
    
    CGRect scrollFrame = [[UIScreen mainScreen] bounds];
    if(scrollFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        [scrollThis setContentSize:CGSizeMake((320 * pageSize), 300)];
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        [scrollThis setContentSize:CGSizeMake((320 * pageSize), 400)];
    }
    
        [self.view addSubview:scrollThis];
    
    
    // スクロールできる背景範囲を指定
    CGRect backFrame = [[UIScreen mainScreen] bounds];
    if(backFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        backFrame = CGRectMake(0, 0, 320 * pageSize, 300);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        backFrame = CGRectMake(0, 0, 320 * pageSize, 400);
        
    }
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:backFrame];
    
    // Add a Itemimage 1
    UIImage *img = [UIImage imageNamed:@"BoissonChocolat"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    
    CGRect imageFrame = [[UIScreen mainScreen] bounds];
    if(imageFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        imageFrame = CGRectMake(320 * 0, 5, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        imageFrame = CGRectMake(320 * 0, 5, 320, 350);
        
    }
    
    imageView.frame = imageFrame;
    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [imageView addGestureRecognizer:tapGestureRecognizer];
    
    [backGroundView addSubview:imageView];


    // Add a Itemimage 2
    UIImage *img2 = [UIImage imageNamed:@"BoissonChocolat02"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img2];
    
    CGRect image2Frame = [[UIScreen mainScreen] bounds];
    if(image2Frame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        image2Frame = CGRectMake(320 * 1, 5, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        image2Frame = CGRectMake(320 * 1, 5, 320, 350);
        
    }
    
    imageView2.frame = image2Frame;
    imageView2.userInteractionEnabled = YES;
    imageView2.clipsToBounds = YES;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [imageView2 addGestureRecognizer:tapGestureRecognizer2];
    
    [backGroundView addSubview:imageView2];
    
    // Add a Itemimage 3
    UIImage *img3 = [UIImage imageNamed:@"BoissonChocolat03"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:img3];
    
    CGRect image3Frame = [[UIScreen mainScreen] bounds];
    if(image3Frame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        image3Frame = CGRectMake(320 * 2, 5, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        image3Frame = CGRectMake(320 * 2, 5, 320, 350);
        
    }
    
    imageView3.frame = image3Frame;
    imageView3.userInteractionEnabled = YES;
    imageView3.clipsToBounds = YES;
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [imageView3 addGestureRecognizer:tapGestureRecognizer3];
    
    [backGroundView addSubview:imageView3];

    
    // Add a Itemimage 4
    UIImage *img4 = [UIImage imageNamed:@"BoissonChocolat04"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:img4];
    
    CGRect image4Frame = [[UIScreen mainScreen] bounds];
    if (image4Frame.size.height == 480) {
        // 3,5inch
        image4Frame = CGRectMake(320 * 3, 5, 320, 280);
    } else {
        // 4inch
        image4Frame = CGRectMake(320 * 3, 5, 320, 350);
    }
    
    imageView4.frame = image4Frame;
    imageView4.userInteractionEnabled = YES;
    imageView4.clipsToBounds = YES;
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [imageView4 addGestureRecognizer:tapGestureRecognizer4];
    
    [backGroundView addSubview:imageView4];
    
    
    CGRect controllFrame = [[UIScreen mainScreen] bounds];
    if(controllFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        controllFrame = CGRectMake(150,360,20,3);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        controllFrame = CGRectMake(150,430,20,3);
        
    }
    
    
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:controllFrame];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:220.f/255.f green:220.f/255.f blue:220.f/255.f alpha:1.f];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    
    pageControl.userInteractionEnabled = YES;
    [pageControl addTarget:self
                    action:@selector(pageControl_Tapped:)
          forControlEvents:UIControlEventValueChanged];
    
    
    [scrollThis addSubview:backGroundView];
    
    
    scrollThis.contentSize = backGroundView.bounds.size;
    [self.view addSubview:pageControl];
    
    

    
}


- (void)constructLabel {
    
    // ブランド名のラベル作成
    CGRect nameFrame = [[UIScreen mainScreen] bounds];
    if(nameFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        nameFrame = CGRectMake(20, 365, 180, 40);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        nameFrame = CGRectMake(20, 435, 180, 40);
        
    }
    _nameLabel = [[UILabel alloc] initWithFrame:nameFrame];
    _nameLabel.text = [NSString stringWithFormat:@"Boisson Chocolat"];
    _nameLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:18];
    _nameLabel.textColor = [UIColor darkGrayColor];
    
    // アイテム名のラベル作成
    CGRect itemFrame = [[UIScreen mainScreen] bounds];
    if(itemFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        itemFrame = CGRectMake(20, 395, 300, 20);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        itemFrame = CGRectMake(20, 470, 300, 20);
    
    }
    _itemLabel = [[UILabel alloc] initWithFrame:itemFrame];
    _itemLabel.text = @"B　Rソフトスクエア　フラット";
    _itemLabel.font = [UIFont fontWithName:@"AxisStd-ExtraLight" size:10];
    _itemLabel.textColor = [UIColor lightGrayColor];
    
    // 値段のラベル
    CGRect priceFrame = [[UIScreen mainScreen] bounds];
    if(priceFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        priceFrame = CGRectMake(230, 365, 150, 40);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        priceFrame = CGRectMake(230, 435, 150, 40);
        
    }
    _priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
    _priceLabel.text = [NSString stringWithFormat:@"¥9,180"];
    _priceLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:18];
    _priceLabel.textColor = [UIColor darkGrayColor];
    
    // 販売先も明記
    CGRect linkFrame = [[UIScreen mainScreen] bounds];
    if(linkFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        linkFrame = CGRectMake(20, 410, 150, 30);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        linkFrame = CGRectMake(20, 490, 150, 30);
        
    }
    _linkLabel = [[UILabel alloc] initWithFrame:linkFrame];
    _linkLabel.text = @"@MAGASEEK";
    _linkLabel.font = [UIFont fontWithName:@"DINMittelschriftStd" size:13];
    _linkLabel.textColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    // 購入ボタン
    UIImage *image = [UIImage imageNamed:@"buy-button"];
    CGRect buyFrame = [[UIScreen mainScreen] bounds];
    if(buyFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        buyFrame = CGRectMake(15, 435, image.size.width, image.size.height);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        buyFrame = CGRectMake(15, 520, image.size.width, image.size.height);
        
    }

    UIButton *buyButton = [[UIButton alloc] initWithFrame:buyFrame];
    [buyButton setImage:image forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(tappedToBuy:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // likeボタン
    _likeImage = [UIImage imageNamed:@"like-button"];
    CGRect likeFrame = [[UIScreen mainScreen] bounds];
    if(likeFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        likeFrame = CGRectMake(240, 435, _likeImage.size.width, _likeImage.size.height);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        likeFrame = CGRectMake(240, 520, _likeImage.size.width, _likeImage.size.height);
    }

    _likebutton = [[UIButton alloc] initWithFrame:likeFrame];
    [_likebutton setImage:_likeImage forState:UIControlStateNormal];
    
    [_likebutton addTarget:self action:@selector(tappedToLike:) forControlEvents:UIControlEventTouchUpInside];
    
    // ADDSUB
    [self.view addSubview:_nameLabel];
    [self.view addSubview:_priceLabel];
    [self.view addSubview:_itemLabel];
    [self.view addSubview:_linkLabel];
    [self.view addSubview:buyButton];
    [self.view addSubview:_likebutton];
}




#pragma mark - control Events

- (void)tappedToLike:(id)sender {
    NSLog(@"You liked this");
    
    // このアイテムをlikeしたとしてボタンの色が変わる
    UIImage *imgPushed = [UIImage imageNamed:@"like-button-push"];
    [_likebutton setImage:imgPushed forState:UIControlStateNormal];
    
    // もう一度ボタンを押すと、likeをcancelしたとする
    [_likebutton addTarget:self action:@selector(canceled:) forControlEvents:UIControlEventTouchUpInside];
    
   
}

- (void)canceled:(id)sender {
    NSLog(@"You canceled to like this.");
    
    // このアイテムをlikeしたことをcancelしたとしてボタン色が戻る
    [_likebutton setImage:_likeImage forState:UIControlStateNormal];
    
    // tappedToLikeへ繰り返し
    [_likebutton addTarget:self action:@selector(tappedToLike:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)backToView:(id)sender {
    
    // 前のページに戻る
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
   [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
    
    
}


- (IBAction)shareThis:(id)sender {
    
    NSString *text  = @"You gets invited! Download this app below and enjoy it.";
    NSURL *url = [NSURL URLWithString:@"http://wishfeed.me/"];
   
    NSArray *activityItems = @[text, url];

    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = [[NSArray alloc] initWithObjects:UIActivityTypeMessage,
                                                    UIActivityTypePostToFacebook,
                                                    UIActivityTypePostToTwitter,nil];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}

- (void)tappedToBuy:(id)sender {
    
    NSLog(@"You want to buy.");
    
    FWWebViewController *webViewController = [[FWWebViewController alloc] init];
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView

{
    CGFloat pageWidth = scrollThis.frame.size.width;
    if ((NSInteger)fmod(scrollThis.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        pageControl.currentPage = scrollThis.contentOffset.x / pageWidth;
    }
}


- (void)pageControl_Tapped:(id)sender {
    
    CGRect frame = scrollThis.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    [scrollThis scrollRectToVisible:frame animated:YES];
}



@end
