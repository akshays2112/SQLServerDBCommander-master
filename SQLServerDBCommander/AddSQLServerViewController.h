//
//  AddSQLServerViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLServer.h"

@interface AddSQLServerViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) NSMutableArray *servers;
@property (nonatomic) UITableView *svrtv;

@end
