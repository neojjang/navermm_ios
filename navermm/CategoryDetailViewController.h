//
//  CategoryDetailViewController.h
//  navermm
//
//  Created by kiban on 2013/08/09.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMMApiClass.h"

@interface CategoryDetailViewController : UIViewController<NMMApiDelegate,UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) NSString *categoryName;  // CategoryViewからのデータ受け渡し用(ユーザが選択したカテゴリ名)
@property (copy, nonatomic) NSString *categoryId;    // CategoryViewからのデータ受け渡し用(ユーザが選択したカテゴリID)
@property (weak, nonatomic) IBOutlet UITableView *matomeListTable;
@property (weak, nonatomic) IBOutlet UILabel *description;
- (IBAction)refreshList:(id)sender;

- (IBAction)fav100:(id)sender;
- (IBAction)fav500:(id)sender;
- (IBAction)fav1000:(id)sender;
@end
