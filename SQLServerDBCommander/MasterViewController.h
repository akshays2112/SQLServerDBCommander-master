//
//  MasterViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLServer.h"
#import "AddSQLServerViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
