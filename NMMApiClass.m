//
//  NMMApiClass.m
//  navermm
//
//  Created by kiban on 2013/08/11.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import "NMMApiClass.h"

@implementation NMMApiClass
{
    // APIの基本URL
    NSString *url;
    // 非同期通信でデータを受け取る為の変数
    NSMutableData *asyncData;
    NSURLConnection *connection;
}

/* 初期化 */
- (id)init
{
    if(self = [super init]) {
        url = @"http://iapp.navermm.com";
    }
    return self;
}

/* APIからのデータ取得を開始する */
- (void)start:(NSString *)categoryId fr:(NSString *)favRange
{
    // URLを作成
    NSString *requestUrl = [NSString stringWithFormat:@"%@?c=%@&f=%@",url,categoryId,favRange];
    NSURL    *nsRequestUrl = [NSURL URLWithString:requestUrl];
    
    // リクエストを送信
    NSURLRequest *request = [NSURLRequest requestWithURL:nsRequestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:7.0];
    
    // 既に通信中の場合は通信中の接続をキャンセルする
    if (connection) [connection cancel];
    
    connection = [
                                   [NSURLConnection alloc]
                                   initWithRequest : request
                                   delegate : self
                                   ];
	if (connection==nil) {
		// コネクションの作成に失敗した時の処理
        [self.delegate NMMApiFetchFail:@"通信プラグラムエラー"];
	}
}

/* APIからのデータ取得をキャンセルする */
- (void)cancel
{
    // 通信中の場合は通信中の接続をキャンセルする
    if (connection) [connection cancel];
}

/* (非同期)サーバからレスポンスが帰って来た時 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	// データを初期化
	asyncData = [[NSMutableData alloc] init];
}

/* (非同期)サーバからデータが送られて来た時 */
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 受信したデータをasyncDataに追加する
    [asyncData appendData:data];
}

/* (非同期)データのロードが完了した時 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
	NSString *jsonRow = [
                         [NSString alloc]
                         initWithData : asyncData
                         encoding : NSUTF8StringEncoding
                         ];
    NSData  *jsonData = [jsonRow dataUsingEncoding:NSUnicodeStringEncoding];
    NSError *error=nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    [self.delegate NMMApiFetchSuccess:(NSArray *)jsonArray];
}

/* (非同期)サーバからエラーが返された時 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self.delegate NMMApiFetchFail:@"サーバとの通信に失敗。電波状況を確認して下さい。"];
}

@end