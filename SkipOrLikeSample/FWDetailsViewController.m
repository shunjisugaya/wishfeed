//
//  FWDetailsViewController.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/18.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWDetailsViewController.h"
#import "FWViewController.h"

#import <MDCSwipeToChoose/MDCSwipeToChoose.h>


@interface FWDetailsViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;


@end

@implementation FWDetailsViewController
@synthesize itemsArray;
@synthesize itemName;
@synthesize itemImage;
@synthesize itemPrice;

@synthesize cardView;


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
                                                                 action:@selector(actionMethod:)];
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
/*

 // ユーザーがスワイプしきらずにキャンセルした場合
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You Couldn't Decide on %@.", self.items.name);
}

// ユーザーが完全にスワイプした場合
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
 
*/

#pragma mark - view Construction

- (void)constructView {
    

    // スクロールできるようにする
    NSInteger pageSize = 1;
    
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
    
    /*
    // Parseの「Items」の中にデータが存在するか確認する
    PFQuery *query =[PFQuery queryWithClassName:@"Items"];
    [query whereKey:@"objectId" equalTo:@"3pRWTs8Mdw"];
        
    NSArray *array = [query findObjects];
    NSData *imageData = nil;
    
    // データが存在する場合
    if (1 <= [array count]) {
        //保存した画像データを取得する
        for( PFObject *objectData in array )
        {
            PFFile *fileData = [objectData objectForKey:@"Image"];
            imageData = [fileData getData];
        }
        
        if (nil != imageData) {
            UIImage *img = [[UIImage alloc] initWithData:imageData];
            _imageView = [[UIImageView alloc] initWithImage:img];
            CGRect imageFrame = [[UIScreen mainScreen] bounds];
            if(imageFrame.size.height == 480){
                // ここに3.5inchのiPhone用のコードを記入
                imageFrame = CGRectMake(320 * 0, 5, 320, 280);
            }else{
                // ここは4inchの新しいiPhone向けのコードを記入
                imageFrame = CGRectMake(320 * 0, 5, 320, 350);
            }
            _imageView.frame = imageFrame;
            _imageView.userInteractionEnabled = YES;
            _imageView.clipsToBounds = YES;
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(tappedToBuy:)];
            [_imageView addGestureRecognizer:tapGestureRecognizer];
            [backGroundView addSubview:_imageView];
        }
    }  */
    
     
    // Add a Itemimage 1
    
    UIImage *img = itemImage;
    _imageView = [[UIImageView alloc] initWithImage:img];
    CGRect imageFrame = [[UIScreen mainScreen] bounds];
    if(imageFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        imageFrame = CGRectMake(320 * 0, 5, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        imageFrame = CGRectMake(320 * 0, 5, 320, 350);
        
    }
    _imageView.frame = imageFrame;
    _imageView.userInteractionEnabled = YES;
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [_imageView addGestureRecognizer:tapGestureRecognizer];

     
    [backGroundView addSubview:_imageView];
        
    
    /*
    // Add a Itemimage 2
    UIImage *img2 = [UIImage imageNamed:@"BoissonChocolat02"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img2];
    
    CGRect image2Frame = [[UIScreen mainScreen] bounds];
    if(image2Frame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        image2Frame = CGRectMake(320 * 1, 0, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        image2Frame = CGRectMake(320 * 1, 0, 320, 350);
        
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
        image3Frame = CGRectMake(320 * 2, 0, 320, 280);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        image3Frame = CGRectMake(320 * 2, 0, 320, 350);
        
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
        image4Frame = CGRectMake(320 * 3, 0, 320, 280);
    } else {
        // 4inch
        image4Frame = CGRectMake(320 * 3, 0, 320, 350);
    }
    
    imageView4.frame = image4Frame;
    imageView4.userInteractionEnabled = YES;
    imageView4.clipsToBounds = YES;
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer *tapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedToBuy:)];
    [imageView4 addGestureRecognizer:tapGestureRecognizer4];
    
    [backGroundView addSubview:imageView4];
     */
    
    
    /*
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
    
    [self.view addSubview:pageControl];
    
    */
    
    [scrollThis addSubview:backGroundView];
    
    
    scrollThis.contentSize = backGroundView.bounds.size;
    
    
    

    
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
    _nameLabel.text = [NSString stringWithFormat:@"%@",itemName];
    _nameLabel.font = [UIFont fontWithName:@"AxisStd-Regular" size:18];
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
    _itemLabel.font = [UIFont fontWithName:@"AxisStd-Regular" size:11];
    _itemLabel.textColor = [UIColor lightGrayColor];
    
    // 値段のラベル
    CGRect priceFrame = [[UIScreen mainScreen] bounds];
    if(priceFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        priceFrame = CGRectMake(150, 365, 150, 40);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        priceFrame = CGRectMake(150, 435, 150, 40);
        
    }
    _priceLabel = [[UILabel alloc] initWithFrame:priceFrame];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",itemPrice];
    _priceLabel.font = [UIFont fontWithName:@"AxisStd-Bold" size:18];
    _priceLabel.textColor = [UIColor darkGrayColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    
    // 販売先も明記
    CGRect linkFrame = [[UIScreen mainScreen] bounds];
    if(linkFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        linkFrame = CGRectMake(20, 405, 150, 30);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        linkFrame = CGRectMake(20, 485, 150, 30);
        
    }
    _linkLabel = [[UILabel alloc] initWithFrame:linkFrame];
    _linkLabel.text = @"@MAGASEEK";
    _linkLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:10];
    _linkLabel.textColor = [UIColor darkGrayColor];
    
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
    NSLog(@"You liked %@", self.itemName);
    
    // このアイテムをlikeしたとしてボタンの色が変わる
    self.likeImagePushed = [UIImage imageNamed:@"like-button-push"];
    [_likebutton setImage:self.likeImagePushed forState:UIControlStateNormal];
    
    // もう一度ボタンを押すと、likeをcancelしたとする
    [_likebutton addTarget:self action:@selector(canceled:) forControlEvents:UIControlEventTouchUpInside];
    
   
}

- (void)canceled:(id)sender {
    NSLog(@"You canceled to like %@", self.itemName);
    
    // このアイテムをlikeしたことをcancelしたとしてボタン色が戻る
    [_likebutton setImage:_likeImage forState:UIControlStateNormal];
    
    // tappedToLikeへ繰り返し
    [_likebutton addTarget:self action:@selector(tappedToLike:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)backToView:(id)sender {
    // likeされたままページ遷移した場合
    // pushされたかを判定
    // pushされてた場合
    if ([_likebutton.currentImage isEqual:self.likeImagePushed]) {
        NSLog(@"%@ has been liked and gonna be into your wishlist.", self.itemName);
        // 前のページに戻る
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        // likeFrontCardView method acts
        [self performSelector:@selector(swipeCard)
                   withObject:nil
                   afterDelay:0.5];
        
        
    // pushされてない場合
    } else if([_likebutton.currentImage isEqual:self.likeImage]){
        NSLog(@"%@ hasn't been matched you anyway.", self.itemName);
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }

}

- (void)swipeCard {
    [self.cardView mdc_swipe:MDCSwipeDirectionRight];
}

// action menu を表示、実行
- (void)actionMethod:(id)sender {
    NSLog(@"Action menu is appeared");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil, nil];
    
    [actionSheet addButtonWithTitle:@"この商品をTwitterでシェア"];
    [actionSheet addButtonWithTitle:@"この商品をLINEで教える"];
    [actionSheet addButtonWithTitle:@"この商品をFacebookでシェア"];
    [actionSheet addButtonWithTitle:@"この商品をSMSで教える"];
    [actionSheet addButtonWithTitle:@"この商品をEメールで教える"];
    
    [actionSheet addButtonWithTitle:@"キャンセル"];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    [actionSheet showInView:self.view.window];
    
}



//UIActionSheetDelegateによるクリック時処理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        { //
            // METHOD TO TWEET
            // Twitter Class 初期化
            SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            // 送信文字列セット(140文字をリミット)
            // ハッシュタグ #wishfeed をデフォルトでツイートに追加
            NSString *message = [[NSString alloc] initWithFormat:@"#wishfeed"];
            if (message.length > 140) {
                message = [message substringToIndex:140];
            }
            
            [tweet setInitialText:message];
            // [CANSEL]ボタンなどのイベントハンドラ定義
            tweet.completionHandler = ^(SLComposeViewControllerResult result) {
                [self dismissViewControllerAnimated:YES completion:nil];
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"Twitter Method has been done.");
                }
            };
            
            // 送信Viewを表示
            [self presentViewController:tweet animated:YES completion:nil];
            
            break;
        } //

        case 1:
            // METHOD TO LINE TO SOMEONE
            
            
            break;
        case 2:
        { //
            // METHOD TO POST IT ON FACEBOOK
            // Facebook Class 初期化
            SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebook setCompletionHandler:^(SLComposeViewControllerResult result) {
                [self dismissViewControllerAnimated:YES completion:nil];
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"sendFacebook succeded");
                }
            }];
        
            // POSTするテキストの初期設定
            NSString *message = [NSString stringWithFormat:@"#wishfeed"];
            [facebook setInitialText:message];
            /*
            // URLをポストする場合
            [facebook addURL:[NSURL URLWithString:@"http://XXXXXXXXXX"]];
            // 画像をポストする場合
            [facebook addImage:[UIImage imageNamed:@"XXX"]];
             */
            // SLComposeViewController 表示
            [self presentViewController:facebook animated:YES completion:nil];
            
            break;
        } //
        case 3:
        { //
            // SMS送信
            //phoneはメッセージを送りたい電話番号
            NSString *phone;
            //messageは、SMSのメッセージ内容
            NSString *message;
            UIViewController *viewController;
            
            // MFMessageComposeViewControllerの初期化
            MFMessageComposeViewController *mFMessageComposeViewController = [MFMessageComposeViewController alloc];
            if ([MFMessageComposeViewController canSendText]) {
                mFMessageComposeViewController.messageComposeDelegate = self;
                mFMessageComposeViewController.recipients = @[phone];
                mFMessageComposeViewController.body = message;
            }
            [viewController presentViewController:mFMessageComposeViewController animated:YES completion:nil];
            
            break;
        }//
        case 4:
            // 5番目のボタンが押されたときの処理を記述する (Safariで追加)
            
            break;
    }
    
}


- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:[UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f] forState:UIControlStateNormal];  //通常時
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];//クリック時
            [button setFont:[UIFont fontWithName:@"AxisStd-Light" size:15.f]];
            
            
       }
        
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"Message Method has been finished.");
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
    
    NSLog(@"You want to buy %@", self.itemName);
    
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
