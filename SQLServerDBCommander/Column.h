//
//  Column.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseObject.h"

@interface Column : NSObject

@property (nonatomic) DatabaseObject *dbobj;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *ispk;
@property (nonatomic) NSString *coltypename;
@property (nonatomic) NSString *collength;
@property (nonatomic) NSString *isnullable;

@end
