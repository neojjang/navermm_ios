//
//  CategoryDetailViewController.m
//  navermm
//
//  Created by kiban on 2013/08/09.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "SVProgressHUD.h"
#import "MatomeViewController.h"

@interface CategoryDetailViewController ()
@end

/* インスタンス変数 */
@implementation CategoryDetailViewController{
    // NaverまとめのまとめのAPIを使用するクラス
    NMMApiClass *NMMApi;
    
    // NaverまとめのまとめAPIから取得したまとめリストを保存しておく変数
    NSArray *matomeList;
    
    // 現在表示しているランキングレンジを保存しておく変数
    NSString *rankRange;
    
}

@synthesize categoryName;
@synthesize categoryId;

/* ビューの初回ロード完了時に実行される処理 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NaverまとめのまとめAPIを使用するクラスの初期化
    NMMApi = [[NMMApiClass alloc]init];
    NMMApi.delegate = self;

    // まとめリストを表示するテーブルのデータソースとデリゲート先に自クラスを指定する
    self.matomeListTable.dataSource = self;
    self.matomeListTable.delegate   = self;
    
    // ナビゲーションバーのスタイルを設定
    [self initNavigationBar];

    // 機能説明用ラベルのスタイルを設定
    [self initDescription];
    
    // まとめリストを取得する
    [self fetchMatomeList:@"100"];
    
    // ランキングレンジを初期化する
    rankRange = @"100";
}

/* ナビゲーションバーのスタイルを設定する */
- (void)initNavigationBar
{
    //タイトルフォント設定
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    //背景色指定
    label.backgroundColor = [UIColor clearColor];
    //フォントサイズ指定
    label.font = [UIFont boldSystemFontOfSize:17.0];
    //影の色指定
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //フォントをセンタリングする
    label.textAlignment = NSTextAlignmentCenter;
    //フォントの色指定
    label.textColor =[UIColor whiteColor];
    //タイトル名
    label.text = categoryName;
    //ナビゲーションバーにセットする
    self.navigationItem.titleView = label;
}

/* アプリ説明用ラベルのスタイルを設定する */
- (void)initDescription
{
    UIImage *backgroundImage = [UIImage imageNamed:@"description.png"];
    self.description.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

/* NaverまとめのまとめAPIからまとめ一覧を取得する処理 */
- (void)fetchMatomeList:(NSString *)favoriteRange
{
    // ステータスバーにネットワークインジケーターを表示する
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // ローディングメッセージを表示する
    [SVProgressHUD showWithStatus:@"通信中"];
    
    [NMMApi start:categoryId fr:favoriteRange];
}

/* APIからのデータ取得が正常に完了した時 */
- (void)NMMApiFetchSuccess:(NSArray *)jsonArray
{
    // ステータスバーにネットワークインジケーターを表示する
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // ローディングメッセージを非表示にする
    [SVProgressHUD dismiss];
    
    // テーブルビューを更新する
    [self updateTableView:(NSArray *)jsonArray];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.matomeListTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

/* APIからのデータ取得に失敗した時 */
- (void)NMMApiFetchFail:(NSString *)errorMsg
{   
    // ステータスバーにネットワークインジケーターを表示する
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // ローディングメッセージを非表示にする
    [SVProgressHUD dismiss];
    
    // エラーメッセージを表示する
    [SVProgressHUD showSuccessWithStatus:errorMsg];
}

/* テーブルビューを更新する処理 */
- (void)updateTableView:(NSArray *)jsonArray
{
    matomeList = jsonArray;
    [self.matomeListTable reloadData];
}

/* テーブルビューのセレクション数を設定 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/* セレクションの行数を設定 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [matomeList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"matomeListCell"];
    
    // categoryListから1行分を取り出し
    NSDictionary *dicRow = [matomeList objectAtIndex:indexPath.row];
    
    // サムネイルをセット
    UIImageView *matomeImageView = (UIImageView *)[cell viewWithTag:0];
    matomeImageView.image = nil;
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    
    dispatch_async(q_global, ^{
        NSString *imageURL = [dicRow objectForKey:@"matome_thumbnail"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
        
        
        dispatch_async(q_main, ^{
            UIImage *image_resize;
            UIGraphicsBeginImageContext(CGSizeMake(69, 69));
            [image drawInRect:CGRectMake(0, 0, 69, 69)];
            image_resize = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [matomeImageView setImage:image_resize];
            [cell layoutSubviews];
        });
    });
    
    // タイトルをセット
    UILabel *matomeTitle = (UILabel *)[cell viewWithTag:1];
    matomeTitle.text = [dicRow objectForKey:@"matome_title"];
    
    // Favorite数をセット
    UILabel *matomeFavorite = (UILabel *)[cell viewWithTag:2];
    matomeFavorite.text = [dicRow objectForKey:@"matome_favorite"];
    
    // 更新日をセット
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZZ"];
    NSDate *date = [formatter dateFromString:[dicRow objectForKey:@"matome_update"]];
    [formatter setDateFormat:@"MM/dd HH:mm"];
    UILabel *matomeUpdate = (UILabel *)[cell viewWithTag:4];
    matomeUpdate.text = [formatter stringFromDate:date];
    
    return cell;
}

/* カテゴリーテーブルのセルがタップされた時の処理 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択状態を解除する
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/* メモリが足らなくなって来た時の処理 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* favorite数フィルターボタンが押された時の動作 */
- (IBAction)fav100:(id)sender
{
    // まとめリストを取得する
    rankRange = @"100";
    [self fetchMatomeList:rankRange];
}
- (IBAction)fav500:(id)sender
{
    // まとめリストを取得する
    rankRange = @"500";
    [self fetchMatomeList:rankRange];
}
- (IBAction)fav1000:(id)sender {
    // まとめリストを取得する
    rankRange = @"1000";
    [self fetchMatomeList:rankRange];
}

// 更新ボタンが押された時の処理
- (IBAction)refreshList:(id)sender {
    [self fetchMatomeList:rankRange];
}

- (void) dealloc{
	// dealloc処理
    [NMMApi cancel];
    [SVProgressHUD dismiss];
}

/* まとめビューにまとめタイトル名とまとめURLを渡す */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //選択されたかセルの行数を取得
    NSIndexPath *indexPath = [self.matomeListTable indexPathForSelectedRow];
    
    // categoryListから1行分を取り出し
    NSDictionary *dicRow = [matomeList objectAtIndex:indexPath.row];
    
    // 移動先のViewにカテゴリidとnameを渡す
    // サブ画面のビューコントローラを取得
    MatomeViewController *aMatomeViewController = (MatomeViewController *)[segue destinationViewController];
    aMatomeViewController.matomeTitle = [dicRow objectForKey:@"matome_title"];
    aMatomeViewController.matomeUrl = [dicRow objectForKey:@"matome_url"];
}
@end
