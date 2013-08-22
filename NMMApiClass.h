//
//  NMMApiClass.h
//  navermm
//
//  Created by kiban on 2013/08/11.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

/* デリゲートメソッド(呼び出し先で実装必須) */
@protocol NMMApiDelegate <NSObject>

- (void)NMMApiFetchSuccess:(NSArray *)jsonArray;
- (void)NMMApiFetchFail:(NSString *)errorMsg;

@end

@interface NMMApiClass : NSObject

@property (nonatomic, assign) id<NMMApiDelegate> delegate;

// イニシャライザ
- (id)init;

// APIからのデータ受信を開始する
- (void)start:(NSString *)categoryId fr:(NSString *)favRange;

// APIとのデータ通信をキャンセルする
- (void)cancel;

@end
