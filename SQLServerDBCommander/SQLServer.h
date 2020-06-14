//
//  SQLServer.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLClient.h"

@interface SQLServer : NSObject <SQLClientDelegate, NSCoding>

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *port;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;
@property (nonatomic) NSMutableArray *systemDBs;
@property (nonatomic) NSMutableArray *userDBs;
@property (nonatomic) UITableView *databasesTableView;

-(void) fetchDatabases;

@end
