//
//  DatabaseObject.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "DatabaseObject.h"
#import "Column.h"
#import "SPViewController.h"
#import "DataCollectionViewController.h"
#import "ForeignKey.h"

@implementation DatabaseObject

-(void) fetchDetails {
    SQLClient* client = [SQLClient sharedInstance];
	client.delegate = self;
	[client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.db.server.name, self.db.server.port] username:self.db.server.username password:self.db.server.password database:self.db.name completion:^(BOOL success) {
		if (success)
		{
            NSString *qry = nil;
            if([self.xtype isEqualToString:@"U"]) {
                qry = [[NSString alloc] initWithFormat:@"select ac.name, isnull(i.is_primary_key, 0) ispk, t.name type, ac.max_length length, ac.is_nullable from sys.objects ao inner join sys.columns ac on ao.object_id = ac.object_id inner join sys.types t on ac.user_type_id = t.user_type_id left join sys.index_columns  ic on ac.object_id = ic.object_id and ac.column_id = ic.column_id left join sys.indexes i on ic.object_id = i.object_id and ic.index_id = i.index_id where ao.type = 'U' and object_name(ao.object_id) = '%@'", self.name];
            } else if([self.xtype isEqualToString:@"V"]) {
                qry = [[NSString alloc] initWithFormat:@"select ac.name, t.name type, ac.max_length length, ac.is_nullable from sys.objects ao inner join sys.columns ac on ao.object_id = ac.object_id inner join sys.types t on ac.user_type_id = t.user_type_id where ao.type = 'V' and object_name(ao.object_id) = '%@'", self.name];
            } else if([self.xtype isEqualToString:@"P"]) {
                qry = [[NSString alloc] initWithFormat:@"exec sp_helptext '%@'", self.name];
            }
			[client execute:qry completion:^(NSArray* data) {
                self.tablecolumns = [[NSMutableArray alloc] init];
                self.viewcolumns = [[NSMutableArray alloc] init];
                self.procsrccode = [[NSMutableString alloc] init];
                self.foreignKeys = [[NSMutableArray alloc] init];
                for (NSArray* table in data)
                    for (NSDictionary* row in table) {
                        if([self.xtype isEqualToString:@"U"] || [self.xtype isEqualToString:@"V"]) {
                            Column *col = [[Column alloc] init];
                            col.dbobj = self;
                            col.name = row[@"name"];
                            col.coltypename = row[@"type"];
                            col.collength = row[@"length"];
                            col.isnullable = row[@"is_nullable"];
                            if([self.xtype isEqualToString:@"U"]) {
                                col.ispk = row[@"ispk"];
                                [self.tablecolumns addObject:col];
                            } else {
                                [self.viewcolumns addObject:col];
                            }
                        } else {
                            [self.procsrccode appendString:row[@"Text"]];
                        }
                    }
                [client disconnect];
                if([self.xtype isEqualToString:@"U"] || [self.xtype isEqualToString:@"V"]) {
                    [self.dbobjdetailsTableView reloadData];
                } else {
                    [(SPViewController *)self.storecProcVC configure];
                }
                if([self.xtype isEqualToString:@"U"]) {
                    [client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.db.server.name, self.db.server.port] username:self.db.server.username password:self.db.server.password database:self.db.name completion:^(BOOL success) {
                        if (success)
                        {
                            [client execute:[[NSString alloc] initWithFormat:@"SELECT f.name AS foreign_key_name, OBJECT_NAME(f.parent_object_id) AS table_name, COL_NAME(fc.parent_object_id, fc.parent_column_id) AS constraint_column_name, OBJECT_NAME (f.referenced_object_id) AS referenced_object, COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS referenced_column_name, is_disabled, delete_referential_action_desc, update_referential_action_desc FROM sys.foreign_keys AS f INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id WHERE f.parent_object_id = OBJECT_ID('%@')", self.name] completion:^(NSArray* data) {
                                for (NSArray* table in data)
                                    for (NSDictionary* row in table) {
                                        ForeignKey *kf = [[ForeignKey alloc] init];
                                        kf.constraintName = row[@"foreign_key_name"];
                                        kf.parentColumnName = row[@"constraint_column_name"];
                                        kf.referencedTableName = row[@"referenced_object"];
                                        kf.referencedColumnName = row[@"referenced_column_name"];
                                        kf.isDisabled = row[@"is_disabled"];
                                        kf.deleteAction = row[@"delete_referential_action_desc"];
                                        kf.updateAction = row[@"update_referential_action_desc"];
                                        [self.foreignKeys addObject:kf];
                                    }
                                [client disconnect];
                                [self.dbobjdetailsTableView reloadData];
                            }];
                        }
                    }];

                }
			}];
		}
	}];
}

-(void) fetchData {
    SQLClient* client = [SQLClient sharedInstance];
	client.delegate = self;
	[client connect:[[NSString alloc] initWithFormat:@"%@:%@", self.db.server.name, self.db.server.port] username:self.db.server.username password:self.db.server.password database:self.db.name completion:^(BOOL success) {
		if (success)
		{
			[client execute:[[NSString alloc] initWithFormat:@"select * from %@", self.name] completion:^(NSArray* data) {
                ((DataCollectionViewController *)self.dataVC).data = data;
                [(DataCollectionViewController *)self.dataVC configure];
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
