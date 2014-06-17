//
//  FWWebViewController.m
//  Wishfeed_α
//
//  Created by Fumitaka Watanabe on 2014/05/20.
//  Copyright (c) 2014年 Fumitaka Watanabe. All rights reserved.
//

#import "FWWebViewController.h"
#import "FWDetailsViewController.h"
#import <SafariServices/SafariServices.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>


@interface FWWebViewController ()

@property(nonatomic,strong) NSURL *url;
@property(nonatomic,strong) NSString *titleUrl;
@property(nonatomic,strong) SSReadingList *readingList;

@end

@implementation FWWebViewController

@synthesize delegate;

- (id) init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadWebView];
    wv.scrollView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Add a button to chancel webView on navigationbar
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow"]
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(backToView:)];
                                   
    self.navigationItem.leftBarButtonItem = backButton;
    
    backButton.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    actionBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"]
                                                 style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(actionMethod:)];
                 
    self.navigationItem.rightBarButtonItem = actionBtn;
    actionBtn.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
}

#pragma mark - Internal Methods

-(void)webViewDidStartLoad:(UIWebView *)webView {
    // ページ読込開始時にインジケータをくるくるさせる
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    refreshBtn.enabled = NO;
    stopBtn.enabled = YES;
    
    [self changeFBButtonStatus];
    
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    // ページ読込完了時にインジケータを非表示にする
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // 読み込み完了したページのtitleを取得する
    _titleUrl = [wv stringByEvaluatingJavaScriptFromString:@"document.title"];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 10, 250, 25);
    titleLabel.font = [UIFont fontWithName:@"AxisStd-Light" size:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];;
    titleLabel.text = _titleUrl;
    
    self.navigationItem.titleView = titleLabel;
    
    refreshBtn.enabled = YES;
    stopBtn.enabled = NO;
    
    [self changeFBButtonStatus];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"error");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark - View construction


- (void)loadWebView {
    
    wv = [[UIWebView alloc] init];
    wv.delegate = self;
    wv.frame = CGRectMake(0, 0, 320, 600);
    wv.scalesPageToFit = YES;
    wv.dataDetectorTypes = UIDataDetectorTypeNone;
    
    
    [self.view addSubview:wv];
    
    
    _url = [NSURL URLWithString:@"http://www.magaseek.com/product/detail/id_001158960?cid=mgsafbrandselect?cid=mgsvizury&utm_content=66350312204"];
    NSURLRequest *req = [NSURLRequest requestWithURL:_url];
    
    [wv loadRequest:req];
    
    CGRect toolFrame = [[UIScreen mainScreen] bounds];
    if(toolFrame.size.height == 480){
        // ここに3.5inchのiPhone用のコードを記入
        toolFrame = CGRectMake(0, 437, 320, 44);
    }else{
        // ここは4inchの新しいiPhone向けのコードを記入
        toolFrame = CGRectMake(0, 525, 320, 44);
        
    }
    
    
    toolBar = [[UIToolbar alloc] initWithFrame:toolFrame];
    [self.view addSubview:toolBar];
    
    
    // making a back button
    backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                            target:self
                                                            action:@selector(backDidAction:)];
    UIToolbar *backBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    backBar.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    backBar.transform = CGAffineTransformMakeScale(-1,1);
    [backBar setItems:[NSArray arrayWithObject:backBtn]];
    UIBarButtonItem *makeBackBtn = [[UIBarButtonItem alloc] initWithCustomView:backBar];
    
    nextBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                            target:self
                                                            action:@selector(nextDidAction:)];
    nextBtn.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                               target:self
                                                               action:@selector(refresh:)];
    refreshBtn.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    stopBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                            target:self
                                                            action:@selector(stopDidAction:)];
    stopBtn.tintColor = [UIColor colorWithRed:0.f/255.f green:169.f/255.f blue:157.f/255.f alpha:1.f];
    
    // ボタンの間隔調整
    UIBarButtonItem *fixspacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil action:nil];
    fixspacer1.width = 10.f;
    
    UIBarButtonItem *fixspacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil action:nil];
    fixspacer2.width = 130.f;
    
    
    NSArray *items = [NSArray arrayWithObjects:makeBackBtn, fixspacer1, nextBtn, fixspacer2, refreshBtn, fixspacer1, stopBtn, nil];
    [toolBar setItems:items];

    
    
    [self changeFBButtonStatus];
    
}

//スクロールビューをドラッグし始めた際に一度実行される
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    self.beginScrollOffsetY = [scrollView contentOffset].y;
}

//スクロールビューがスクロールされるたびに実行され続ける
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (QVToolBarScrollStatusAnimation == self.toolBarScrollStatus) {
        return;
    }
    
    if (self.beginScrollOffsetY < [scrollView contentOffset].y
        && !toolBar.hidden) {
        //スクロール前のオフセットよりスクロール後が多い=下を見ようとした =>スクロールバーを隠す
        [UIView animateWithDuration:0.4 animations:^{
            self.toolBarScrollStatus = QVToolBarScrollStatusAnimation;
            
            CGRect rect = toolBar.frame;
            toolBar.frame = CGRectMake(rect.origin.x,
                                            rect.origin.y + rect.size.height,
                                            rect.size.width,
                                            rect.size.height);
        } completion:^(BOOL finished) {
            
            toolBar.hidden = YES;
            self.toolBarScrollStatus = QVToolBarScrollStatusInit;
        }];
    } else if ([scrollView contentOffset].y < self.beginScrollOffsetY
               && toolBar.hidden
               && 0.0 != self.beginScrollOffsetY) {
        toolBar.hidden = NO;
        [UIView animateWithDuration:0.4 animations:^{
            self.toolBarScrollStatus = QVToolBarScrollStatusAnimation;
            
            CGRect rect = toolBar.frame;
            toolBar.frame = CGRectMake(rect.origin.x,
                                            rect.origin.y - rect.size.height,
                                            rect.size.width,
                                            rect.size.height);
        } completion:^(BOOL finished) {
            
            self.toolBarScrollStatus = QVToolBarScrollStatusInit;
        }];
    }
}





#pragma mark - controll Events
// action menu を表示、実行
- (void)actionMethod:(id)sender {
    NSLog(@"Action menu is appeared");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil, nil];
    
    
    
    [actionSheet addButtonWithTitle:@"リンクをツイート"];
    [actionSheet addButtonWithTitle:@"リンクをLINE"];
    [actionSheet addButtonWithTitle:@"リンクをコピー"];
    [actionSheet addButtonWithTitle:@"リーディングリストに追加"];
    [actionSheet addButtonWithTitle:@"Safariで開く"];
    
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
            // １番目のボタンが押されたときの処理を記述する
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
            // ２番目のボタンが押されたときの処理を記述する
            
            
            break;
        case 2:
        { //
            // ３番目のボタンが押されたときの処理を記述する (リンクをコピー)
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            [board setValue:_url forPasteboardType:@"public.url"];
            
            //アラート表示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"コピーしました。"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
       
            break;
        } //
        case 3:
        { //
            // 4番目のボタンが押されたときの処理を記述する (リーディングリストに追加)
            _readingList = [SSReadingList defaultReadingList];
            NSError *error = [NSError new];
            BOOL status = [_readingList addReadingListItemWithURL:_url
                                                      title:_titleUrl
                                                previewText:nil
                                                      error:&error];
            NSString *message;
            if (status) {
                message = @"追加しました。";
            } else {
                message = @"エラー";
            }
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
            [alertView show];
            
            break;
            
        } //
        case 4:
            // 5番目のボタンが押されたときの処理を記述する (Safariで追加)
            if ([[UIApplication sharedApplication] canOpenURL:_url]) {
                [[UIApplication sharedApplication] openURL:_url];
            } else {
                // エラー処理
                NSLog(@"errored with wrong of the URL");
            }
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


// アイテム詳細ページに戻る
- (void)backToView:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];

    
}

// 前のwebページに戻るボタンが押された
- (void)backDidAction:(id)sender {
    if (wv.canGoBack == YES) {
        [wv goBack];
    }
}


// 次のwebページに進むボタンが押された
- (void)nextDidAction:(id)sender {
    if (wv.canGoForward == YES) {
        [wv goForward];
    }
}


// ページを更新するボタンが押された
- (void)refresh:(id)sender {
    
    [wv reload];
    
    refreshBtn.enabled = NO;
    stopBtn.enabled = YES;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

// ページの更新を停止するボタンが押された
- (void)stopDidAction:(id)sender {
    [wv stopLoading];
    
    refreshBtn.enabled = YES;
    stopBtn.enabled = NO;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 現在のページの状態から、前のページに戻る、次のページに進むの有効/無効判定をしてButtonの有効/無効を設定
- (void)changeFBButtonStatus {
    if (wv.canGoForward == YES) {
        nextBtn.enabled = YES;
    }else {
        nextBtn.enabled = NO;
    }
    
    if (wv.canGoBack == YES) {
        backBtn.enabled = YES;
    }else {
        backBtn.enabled = NO;
    }
}

@end
