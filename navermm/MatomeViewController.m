//
//  MatomeViewController.m
//  navermm
//
//  Created by kiban on 2013/08/11.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import "MatomeViewController.h"
#import "SVProgressHUD.h"

@interface MatomeViewController ()

@end

@implementation MatomeViewController{
    //CGRect bannerFrame;
}

@synthesize matomeTitle;
@synthesize matomeUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/* ビューの初回ロード完了時に実行される処理 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ナビゲーションバーのスタイルを設定
    [self initNavigationBar];
    
    // まとめ表示用webviewのデリゲートに自クラスを指定
    self.matomeWebView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:matomeUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.matomeWebView loadRequest:req];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.bannerView.alpha = 0.f;
    }];
}

/* ナビゲーションバーのスタイルを設定する */
- (void)initNavigationBar
{
    //タイトルフォント設定
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //背景色指定
    label.backgroundColor = [UIColor clearColor];
    //フォントサイズ指定
    label.font = [UIFont boldSystemFontOfSize:17.0];
    //影の色指定
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //フォントをセンタリングする
    // label.textAlignment = NSTextAlignmentCenter;
    //フォントの色指定
    label.textColor =[UIColor whiteColor];
    //タイトル名
    label.text = matomeTitle;
    //ナビゲーションバーにセットする
    self.navigationItem.titleView = label;
}

/* webViewの読み込み開始時の処理 */
-(void)webViewDidStartLoad:(UIWebView*)webView{
    // ローディングメッセージを表示する
    [SVProgressHUD showWithStatus:@"通信中"];
    
    // ステータスバーにインディケータを表示する
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/* webViewの読み込み完了時の処理 */
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    // ローディングメッセージを非表示にする
    [SVProgressHUD dismiss];
    
    // ステータスバーのインディケータを非表示にする
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //CGRect bannerFrame = self.bannerView.frame;
    //bannerFrame.origin.y = self.view.frame.size.height;
    //self.bannerView.frame = bannerFrame;
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    //NSLog(@"%@",@"広告有り");
    [UIView animateWithDuration:0.3f animations:^{
        banner.alpha = 1.f;
    }];
    /*
    CGRect bannerFrame = self.bannerView.frame;
    bannerFrame.origin.y = self.view.frame.size.height - banner.frame.size.height;
    [UIView animateWithDuration:1.0
                     animations:^{
                         banner.frame = bannerFrame;
                     }];
     */
}


- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    //NSLog(@"%@",@"広告無し");
    [UIView animateWithDuration:0.3f animations:^{
        banner.alpha = 0.f;
    }];
    /*
    CGRect bannerFrame = self.bannerView.frame;
    bannerFrame.origin.y = self.view.frame.size.height;
    [UIView animateWithDuration:1.0
                     animations:^{
                         banner.frame = bannerFrame;
                     }];
     */
}


- (void) dealloc{
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.bannerView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
