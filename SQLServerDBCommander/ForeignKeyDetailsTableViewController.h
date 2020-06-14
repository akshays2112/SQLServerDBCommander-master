//
//  ForeignKeyDetailsTableViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/20/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForeignKey.h"

@interface ForeignKeyDetailsTableViewController : UITableViewController

@property (nonatomic) ForeignKey *fkobj;

@end
