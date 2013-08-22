//
//  CategoryViewController.h
//  navermm
//
//  Created by kiban on 2013/08/09.
//  Copyright (c) 2013年 Kosuke.Kurimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryListTable;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *description;

@end
