//
//  SQLServer.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "SQLServer.h"
#import "Database.h"

@implementation SQLServer

-(NSString *)description {
    return self.name;
}

-(void) fetchDatabases {
    SQLClient* client = [SQLClient sharedInstance];
	client.delegate = self;
	[client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.name, self.port] username:self.username password:self.password database:@"master" completion:^(BOOL success) {
		if (success)
		{
			[client execute:@"select name, iif(sid = 0x01, 1, 0) issysdb from sysdatabases" completion:^(NSArray* data) {
                self.systemDBs = [[NSMutableArray alloc] init];
                self.userDBs = [[NSMutableArray alloc] init];
                for (NSArray* table in data)
                    for (NSDictionary* row in table) {
                        Database *dbnew = [[Database alloc] init];
                        dbnew.name = row[@"name"];
                        dbnew.server = self;
                        if([row[@"issysdb"] isEqualToString: @"1"]) {
                            [self.systemDBs addObject:dbnew];
                        } else {
                            [self.userDBs addObject:dbnew];
                        }
                    }
                [client disconnect];
                [self.databasesTableView reloadData];
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
