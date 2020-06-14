//
//  Database.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLServer.h"
#import "CustomQueryDataViewController.h"

@interface Database : NSObject <SQLClientDelegate>

@property (nonatomic) SQLServer *server;
@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray *usertables;
@property (nonatomic) NSMutableArray *userviews;
@property (nonatomic) NSMutableArray *userprocs;
@property (nonatomic) UITableView *dbobjsTableView;
@property (nonatomic) NSString *customQuery;
@property (nonatomic) CustomQueryDataViewController *queryVC;

-(void) fetchDBObjects;
-(void) fetchCustomQueryData;

@end
