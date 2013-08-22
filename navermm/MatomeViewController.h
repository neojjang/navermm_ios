//
//  MatomeViewController.h
//  navermm
//
//  Created by kiban on 2013/08/11.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface MatomeViewController : UIViewController<UIWebViewDelegate,ADBannerViewDelegate>

@property (copy, nonatomic) NSString *matomeTitle;  // CategoryDetailViewからのデータ受け渡し用(ユーザが選択したまとめタイトル)
@property (copy, nonatomic) NSString *matomeUrl;    // CategoryDetailViewからのデータ受け渡し用(ユーザが選択したまとめURL)
@property (weak, nonatomic) IBOutlet UIWebView *matomeWebView;
@property (weak, nonatomic) IBOutlet ADBannerView *bannerView;
@end
