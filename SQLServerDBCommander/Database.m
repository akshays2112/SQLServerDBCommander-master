//
//  Database.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "DatabaseObject.h"

@implementation Database

-(NSString *)description {
    return self.name;
}

-(void) fetchDBObjects {
    SQLClient* client = [SQLClient sharedInstance];
	client.delegate = self;
	[client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.server.name, self.server.port] username:self.server.username password:self.server.password database:self.name completion:^(BOOL success) {
		if (success)
		{
			[client execute:@"select name, xtype from sysobjects where xtype in ('U', 'V', 'P') and category <> 2 order by xtype, name" completion:^(NSArray* data) {
                self.usertables = [[NSMutableArray alloc] init];
                self.userviews = [[NSMutableArray alloc] init];
                self.userprocs = [[NSMutableArray alloc] init];
                for (NSArray* table in data)
                    for (NSDictionary* row in table) {
                        DatabaseObject *dbobj = [[DatabaseObject alloc] init];
                        dbobj.db = self;
                        dbobj.name = row[@"name"];
                        dbobj.xtype = row[@"xtype"];
                        if ([row[@"xtype"] isEqualToString: @"U"]) {
                            [self.usertables addObject:dbobj];
                        } else if ([row[@"xtype"] isEqualToString: @"V"]) {
                            [self.userviews addObject:dbobj];
                        } else if ([row[@"xtype"] isEqualToString: @"P"]) {
                            [self.userprocs addObject:dbobj];
                        }
                    }
                [client disconnect];
                [self.dbobjsTableView reloadData];
			}];
		}
	}];
}

-(void) fetchCustomQueryData {
    SQLClient* client = [SQLClient sharedInstance];
	client.delegate = self;
	[client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.server.name, self.server.port] username:self.server.username password:self.server.password database:self.name completion:^(BOOL success) {
		if (success)
		{
			[client execute:self.customQuery completion:^(NSArray* data) {
                ((CustomQueryDataViewController *)self.queryVC).data = data;
                [(CustomQueryDataViewController *)self.queryVC configure];
                [client disconnect];
			}];
		}
	}];
}


//Required
- (void)error:(NSString*)error code:(int)code severity:(int)severity
{
	NSLog(@"Error #%d: %@ (Severity %d)", code, error, severity);
	[[[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

//Optional
- (void)message:(NSString*)message
{
	NSLog(@"Message: %@", message);
}

@end
