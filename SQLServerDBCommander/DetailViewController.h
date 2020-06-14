//
//  DetailViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLServer.h"
#import "Database.h"
#import "DatabaseObjectsTableViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UITableView *databasesTableView;

@end
