//
//  FWViewController.m
//  SkipOrLikeSample
//
//  Created by Fumitaka Watanabe on 2014/05/13.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//


#import "FWViewController.h"
#import "FWItems.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>



@interface FWViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic) NSMutableArray *items;

@end

@implementation FWViewController


#pragma mark - Object Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        // This view controller maintains a list of ChoosePersonView
        // instances to display.
        _items = [[self defaultItems] mutableCopy];
        
    }
    return self;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Add buttons to programmatically swipe the view left or right.
    // See the `nopeFrontCardView` and `likeFrontCardView` methods.
    [self constructSkipButton];
    [self constructLikedButton];
    [self constructMoreDetailsButton];
    
    // Display the first ChoosePersonView in front. Users can swipe to indicate
    // whether they like or dislike the person displayed.
    self.frontCardView = [self popItemViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:self.frontCardView];
    
    // Display the second ChoosePersonView in back. This view controller uses
    // the MDCSwipeToChooseDelegate protocol methods to update the front and
    // back views after each user swipe.
    self.backCardView = [self popItemViewWithFrame:[self backCardViewFrame]];
    [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // wishfeedのタイトルを表示
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation-title"]];
    self.navigationItem.titleView = titleImageView;
    
    /*
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.textColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    title.text = [NSString stringWithFormat:@"%@", self.currentItem.name];
    title.font =[UIFont fontWithName:@"AxisStd-Light" size:15];
    [title sizeToFit];
    self.navigationItem.titleView = title;
    */
    
    // Menuボタンをナビゲーションバーに追加
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(menuAppeared:)];
    self.navigationItem.leftBarButtonItem = menu;
    menu.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - MDCSwipeToChooseDelegate Protocol Methods

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"You Couldn't Decide on %@.", self.currentItem.name);
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    // MDCSwipeToChooseView shows "SKIP" on swipes to the left,
    // and "LIKE" on swipes to the right.
    if (direction == MDCSwipeDirectionLeft) {
        // SKIPした時
        NSLog(@"You Skipped %@.", self.currentItem.name);
        // skipした場合の処理はここへ
        // ・・・・
    } else {
        // LIKEした時
        NSLog(@"You Liked %@.", self.currentItem.name);
        // LIKEした場合の処理
        // LIKEしたアイテムはWishlistに追加される
        // ・・・・
        
    }
    
    
    // MDCSwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // MDCSwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popItemViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 3.f;
                         } completion:nil];
    }
}

#pragma mark - Internal Methods

- (void)setFrontCardView:(FWChooseItemView *)frontCardView {
    // Keep track of the person currently being chosen.
    // Quick and dirty, just for the purposes of this sample app.
    _frontCardView = frontCardView;
    self.currentItem = frontCardView.items;
    self.tapGesturerRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hadleTapped:)];
    [frontCardView addGestureRecognizer:self.tapGesturerRecognizer];
}

- (NSArray *)defaultItems {
    // It would be trivial to download these from a web service
    // as needed, but for the purposes of this sample app we'll
    // simply store them in memory.v
    
    /*
    // Parseの「Items」の中にデータが存在するか確認する
    PFQuery *query =[PFQuery queryWithClassName:@"Items"];
    [query whereKey:@"objectId" equalTo:@"93QQOFEKR4"];
    
    NSArray *parseArray = [query findObjects];
    NSData *imageData = nil;
    NSString *nameString = nil;
    NSString *priceString = nil;
    
    
     // データが存在する場合
    if (1 <= [parseArray count]) {
        //保存した画像データを取得する
        for( PFObject *objectData in parseArray )
        {
            PFFile *fileData = [objectData objectForKey:@"Image"];
            imageData = [fileData getData];
            
            nameString = objectData[@"BrandName"];
            priceString = objectData[@"Price"];
        }
    }
     */
     
    
    return @[[[FWItems alloc]initWithName:@"Boisson Chocolat"
                                    image:[UIImage imageNamed:@"BoissonChocolat"]
                                    price:@"7,869"],
             [[FWItems alloc]initWithName:@"Sunday Morning"
                                    image:[UIImage imageNamed:@"SundayMorning"]
                                    price:@"3,564"],
             [[FWItems alloc] initWithName:@"BONICA DOT"
                                     image:[UIImage imageNamed:@"bonicadot"]
                                     price:@"17,280"],
             [[FWItems alloc] initWithName:@"TOMS"
                                    image:[UIImage imageNamed:@"TOMS02"]
                                    price:@"8,424"],
             [[FWItems alloc] initWithName:@"prix de fleur"
                                    image:[UIImage imageNamed:@"prixdefleur"]
                                    price:@"3,800"],
             [[FWItems alloc] initWithName:@"MERCURYDUO"
                                    image:[UIImage imageNamed:@"MERCURYDUO"]
                                    price:@"745,200"],
             [[FWItems alloc] initWithName:@"DORAMIK"
                                    image:[UIImage imageNamed:@"DORAMIK"]
                                    price:@"3,996"],
             [[FWItems alloc] initWithName:@"I am I"
                                    image:[UIImage imageNamed:@"IamI"]
                                    price:@"7,200"],
             [[FWItems alloc] initWithName:@"Amani"
                                    image:[UIImage imageNamed:@"Amani"]
                                    price:@"11,232"],
             [[FWItems alloc] initWithName:@"Hilfiger Denim"
                                    image:[UIImage imageNamed:@"Hilfiger Denim"]
                                    price:@"9,200"],
             [[FWItems alloc] initWithName:@"Ray-Ban"
                                    image:[UIImage imageNamed:@"RayBan"]
                                    price:@"13,400"],
             [[FWItems alloc] initWithName:@"Grammer Kills"
                                    image:[UIImage imageNamed:@"GrammerKills"]
                                    price:@"2,300"],
             [[FWItems alloc] initWithName:@"Kaene"
                                    image:[UIImage imageNamed:@"Kaene"]
                                    price:@"25,920"],
             [[FWItems alloc] initWithName:@"Another Edition"
                                    image:[UIImage imageNamed:@"AnotherEdition"]
                                    price:@"3,024"],
             [[FWItems alloc] initWithName:@"IENA"
                                    image:[UIImage imageNamed:@"IENA"]
                                    price:@"8,640"],
             [[FWItems alloc] initWithName:@"X-girl First Stage"
                                    image:[UIImage imageNamed:@"X-girlFirstStage"]
                                    price:@"5,940"],
             [[FWItems alloc] initWithName:@"LOWRYS FARM"
                                    image:[UIImage imageNamed:@"LOWRYSFARM"]
                                    price:@"1,999"],
             [[FWItems alloc] initWithName:@"TOMS"
                                    image:[UIImage imageNamed:@"TOMS"]
                                    price:@"12,800"],
             [[FWItems alloc] initWithName:@"MURUA"
                                     image:[UIImage imageNamed:@"MURUA03"]
                                     price:@"6,780"]
             ];
    
}

    
- (FWChooseItemView *)popItemViewWithFrame:(CGRect)frame {;
   
    // 配列のアイテムが何もなくなった場合の処理
    if ([_items count] == 0) {
        return nil;
    }

    
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.delegate = self;
    options.threshold = 160.f;
    options.onPan = ^(MDCPanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 7.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };
    
   // itemViewを作る　フレームと配列の[0]とアイテムとMDCSwipeChooseのoptionsを使用
    FWChooseItemView *itemView = [[FWChooseItemView alloc] initWithFrame:frame
                                                                   items:self.items[0]
                                                                 options:options];
    
    // [0]のアイテムは画面から消えたら配列から削除
    // [0]を消すと次の配列のアイテムが前に詰められて[0]になる。の繰り返し
    [self.items removeObjectAtIndex:0];
    return itemView;
}

#pragma mark View Contruction
- (CGRect)frontCardViewFrame {
    CGRect r = [[UIScreen mainScreen] bounds];
    if(r.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        return CGRectMake(17,85,285,280);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        return CGRectMake(17,105,285,330);
    }
}

- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 7.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

// Create and add the "nope" button.
- (void)constructSkipButton {
    UIImage *image = [UIImage imageNamed:@"skip"];
    UIButton *button = [UIButton alloc];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
   
    CGRect skipFrame = [[UIScreen mainScreen] bounds];
    if(skipFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        skipFrame = CGRectMake(19,400,135,45);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        skipFrame = CGRectMake(19,460,135,45);
        
        
    }
    
    button.frame = skipFrame;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(skipFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

// Create and add the "like" button.
- (void)constructLikedButton {
    UIImage *image = [UIImage imageNamed:@"like"];
    UIButton *button = [UIButton alloc];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect likeFrame = [[UIScreen mainScreen] bounds];
    if(likeFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        likeFrame = CGRectMake(167,400,137.5,45);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
       likeFrame = CGRectMake(167,460,137.5,45);
    }
    
    button.frame = likeFrame;
    [button setImage:image forState:UIControlStateNormal];
       [button addTarget:self
               action:@selector(likeFrontCardView)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)constructMoreDetailsButton {
    // MoreDetails button
    // UIbutton を作成
    UIImage *image = [UIImage imageNamed:@"more"];
    UIButton *buttonMoreDetails = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonMoreDetails setImage:image forState:UIControlStateNormal];
    [buttonMoreDetails sizeToFit];
    
    // 表示するフレームを設定
    
    CGRect moreFrame = [[UIScreen mainScreen] bounds];
    if(moreFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        moreFrame = CGRectMake(115, 445, 90, 25);
        
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        moreFrame = CGRectMake(110, 520, 100, 30);
        [self.view addSubview:buttonMoreDetails];
    }
    
    buttonMoreDetails.frame = moreFrame;
    [buttonMoreDetails addTarget:self
                          action:@selector(viewMoreDetails:)
                forControlEvents:UIControlEventTouchUpInside];
    
    

}



#pragma mark Control Events

- (void)menuAppeared:(id)sender {
    NSLog(@"Menu is here.");
    
}


- (void)hadleTapped:(id)sender{
    NSLog(@"You Tapped %@.", self.currentItem.name);
    
    FWDetailsViewController *detailsView = [[FWDetailsViewController alloc] init];
   // 詳細ページに遷移＃01
    if (detailsView) {
        [self.navigationController pushViewController:detailsView animated:YES];
        
        detailsView.itemName = self.currentItem.name;
        detailsView.itemImage = self.currentItem.image;
        detailsView.itemPrice = self.currentItem.price;
        detailsView.cardView = self.frontCardView;
        

    }
}


// Programmatically "nopes" the front card view.
- (void)skipFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}

// Programmatically "likes" the front card view.
- (void)likeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
}


- (void)viewMoreDetails:(id)sender {
    NSLog(@"You Wanna Check More Details of %@.", self.currentItem.name);
    
    FWDetailsViewController *detailsView = [[FWDetailsViewController alloc] init];
    // #01と同様
    if (detailsView) {
        [self.navigationController pushViewController:detailsView animated:YES];
        
        detailsView.itemName = self.currentItem.name;
        detailsView.itemImage = self.currentItem.image;
        detailsView.itemPrice = self.currentItem.price;
        detailsView.cardView = self.frontCardView;
    }
    
    
 
}

@end
