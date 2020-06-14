//
//  ForeignKey.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/20/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseObject.h"

@interface ForeignKey : NSObject

@property (nonatomic) NSString *constraintName;
@property (nonatomic) NSString *parentColumnName;
@property (nonatomic) NSString *referencedTableName;
@property (nonatomic) NSString *referencedColumnName;
@property (nonatomic) NSString *isDisabled;
@property (nonatomic) NSString *deleteAction;
@property (nonatomic) NSString *updateAction;

@end
