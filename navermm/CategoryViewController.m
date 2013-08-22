//
//  CategoryViewController.m
//  navermm
//
//  Created by kiban on 2013/08/09.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CategoryViewController ()

@end

/* インスタンス変数 */
@implementation CategoryViewController {
    NSArray *categoryList;
}

/* ビューの初回ロード完了時に実行される処理 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // カテゴリーリストテーブルのデータ初期化
    [self initCategoryTableCellsData];
    
	// カテゴリーリストを表示するテーブルのデータソースとデリゲート先に自クラスを指定する
    self.categoryListTable.dataSource = self;
    self.categoryListTable.delegate   = self;
    
    // ナビゲーションバーのスタイルを設定
    [self initNavigationBar];
    
    // アプリ説明用ラベルのスタイルを設定
    [self initDescription];
}

/* メモリが少なくなっている時の処理 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* カテゴリーリストテーブルに表示するセルの項目一覧を初期化する処理 */
- (void)initCategoryTableCellsData
{
    NSDictionary *girls = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"girls",@"id",
                           @"ガールズ",@"name",
                           @"girls_ico.png",@"icon",
                           @"0.102",@"red",
                           @"0.737",@"green",
                           @"0.612",@"blue",
                           @"1.0",@"alpha",
                           nil];
    
    NSDictionary *news = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"news",@"id",
                          @"ニュース･ゴシップ",@"name",
                          @"news_ico.png",@"icon",
                          @"0.086",@"red",
                          @"0.627",@"green",
                          @"0.522",@"blue",
                          @"1.0",@"alpha",
                          nil];
    
    NSDictionary *entertainment = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"entertainment",@"id",
                                   @"エンタメ･カルチャー",@"name",
                                   @"entertainment_ico.png",@"icon",
                                   @"0.180",@"red",
                                   @"0.800",@"green",
                                   @"0.443",@"blue",
                                   @"1.0",@"alpha",
                                   nil];
    
    NSDictionary *spot = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"spot",@"id",
                          @"おでかけ･グルメ",@"name",
                          @"spot_ico.png",@"icon",
                          @"0.153",@"red",
                          @"0.682",@"green",
                          @"0.376",@"blue",
                          @"1.0",@"alpha",
                          nil];
    
    NSDictionary *life = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"life",@"id",
                          @"暮らし･アイデア",@"name",
                          @"life_ico.png",@"icon",
                          @"0.204",@"red",
                          @"0.596",@"green",
                          @"0.859",@"blue",
                          @"1.0",@"alpha",
                          nil];
    
    NSDictionary *recipe = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"recipe",@"id",
                            @"レシピ",@"name",
                            @"recipe_ico.png",@"icon",
                            @"0.161",@"red",
                            @"0.502",@"green",
                            @"0.725",@"blue",
                            @"1.0",@"alpha",
                            nil];
    
    NSDictionary *wellness = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"wellness",@"id",
                              @"カラダ",@"name",
                              @"wellness_ico.png",@"icon",
                              @"0.945",@"red",
                              @"0.769",@"green",
                              @"0.059",@"blue",
                              @"1.0",@"alpha",
                              nil];
    
    NSDictionary *business = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"business",@"id",
                              @"ビジネススキル",@"name",
                              @"business_ico.png",@"icon",
                              @"0.953",@"red",
                              @"0.612",@"green",
                              @"0.071",@"blue",
                              @"1.0",@"alpha",
                              nil];
    
    NSDictionary *tech = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"tech",@"id",
                          @"IT･ガジェット",@"name",
                          @"tech_ico.png",@"icon",
                          @"0.902",@"red",
                          @"0.494",@"green",
                          @"0.133",@"blue",
                          @"1.0",@"alpha",
                          nil];
    
    NSDictionary *design = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"design",@"id",
                            @"デザイン･アート",@"name",
                            @"design_ico.png",@"icon",
                            @"0.827",@"red",
                            @"0.329",@"green",
                            @"0.000",@"blue",
                            @"1.0",@"alpha",
                            nil];
    
    NSDictionary *trivia = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"trivia",@"id",
                            @"雑学",@"name",
                            @"trivia_ico.png",@"icon",
                            @"0.906",@"red",
                            @"0.298",@"green",
                            @"0.235",@"blue",
                            @"1.0",@"alpha",
                            nil];
    
    NSDictionary *humor = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"humor",@"id",
                           @"おもしろ",@"name",
                           @"humor_ico.png",@"icon",
                           @"0.753",@"red",
                           @"0.224",@"green",
                           @"0.169",@"blue",
                           @"1.0",@"alpha",
                           nil];
    
    NSDictionary *popular = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"popular",@"id",
                             @"定番",@"name",
                             @"popular_ico.png",@"icon",
                             @"0.498",@"red",
                             @"0.549",@"green",
                             @"0.553",@"blue",
                             @"1.0",@"alpha",
                             nil];
    categoryList = [[NSMutableArray alloc] initWithObjects:girls, news, entertainment, spot, life, recipe, wellness, business, tech ,design, trivia, humor, popular, nil];
}


/* カテゴリーテーブルのセレクション数を設定 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/* カテゴリーテーブルのセレクションの行数を設定 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // カテゴリーの数をセット
    return [categoryList count];
}

/* カテゴリーテーブルの各セルの表示内容を設定 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryListCell"];
    
    // categoryListから1行分を取り出し
    NSDictionary *dicRow = [categoryList objectAtIndex:indexPath.row];
    
    // セルのタイトルをセット
    cell.textLabel.text = [dicRow objectForKey:@"name"];
    
    // セルの画像をセット
    UIImage* image = [UIImage imageNamed:[dicRow objectForKey:@"icon"]];
    UIGraphicsBeginImageContext(CGSizeMake(32,32));
    [image drawInRect:CGRectMake(0, 0, 32, 32)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.imageView.image = newImage;
    
    // セルの文字色を白にする
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // categoryListから1行分を取り出し
    NSDictionary *dicRow = [categoryList objectAtIndex:indexPath.row];
    
    // セルの色を設定する
    CGFloat red = [[dicRow objectForKey:@"red"] floatValue];
    CGFloat green = [[dicRow objectForKey:@"green"] floatValue];
    CGFloat blue = [[dicRow objectForKey:@"blue"] floatValue];
    CGFloat alpha = [[dicRow objectForKey:@"alpha"] floatValue];
    cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/* カテゴリーテーブルのセルがタップされた時の処理 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択状態を解除する
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/* アプリ説明用ラベルのスタイルを設定する */
- (void)initDescription
{
    UIImage *backgroundImage = [UIImage imageNamed:@"description.png"];
    self.description.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}


/* ナビゲーションバーのスタイルを設定する */
- (void)initNavigationBar
{
    //ナビゲーションバーの背景画像を設定
    //iOSのバージョン取得
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 5.0) {
        //iOSのバージョンが5.0以上の処理
        UIImage *backgroundImage = [UIImage imageNamed:@"navbar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    } else {
        //iOSのバージョンが5.0未満の処理
        NSString *backgroundResource = [[NSBundle mainBundle] pathForResource:@"navbar" ofType:@"png"];
        [self.navigationController.navigationBar.layer setContents:(id)[UIImage imageWithContentsOfFile: backgroundResource].CGImage];
    }

    //タイトルフォント設定
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
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
    label.text = @"NAVERまとめのまとめ";
    //ナビゲーションバーにセットする
    self.navigationItem.titleView = label;
}

/* カテゴリー詳細ビューにカテゴリ名とカテゴリIDを渡す */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //選択されたかセルの行数を取得
    NSIndexPath *indexPath = [self.categoryListTable indexPathForSelectedRow];
    
    // categoryListから1行分を取り出し
    NSDictionary *dicRow = [categoryList objectAtIndex:indexPath.row];
    
    // 移動先のViewにカテゴリidとnameを渡す
    // サブ画面のビューコントローラを取得
    CategoryDetailViewController *aCategoryDetailViewController = (CategoryDetailViewController *)[segue destinationViewController];
    aCategoryDetailViewController.categoryName = [dicRow objectForKey:@"name"];
    aCategoryDetailViewController.categoryId = [dicRow objectForKey:@"id"];
}

@end

