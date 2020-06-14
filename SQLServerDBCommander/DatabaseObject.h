//
//  DatabaseObject.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"

@interface DatabaseObject : NSObject <SQLClientDelegate>

@property (nonatomic) Database *db;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *xtype;
@property (nonatomic) NSMutableArray *tablecolumns;
@property (nonatomic) NSMutableArray *viewcolumns;
@property (nonatomic) NSMutableString *procsrccode;
@property (nonatomic) UITableView *dbobjdetailsTableView;
@property (nonatomic) UIViewController *storecProcVC;
@property (nonatomic) UIViewController *dataVC;
@property (nonatomic) NSMutableArray *foreignKeys;

-(void) fetchDetails;
-(void) fetchData;

@end
