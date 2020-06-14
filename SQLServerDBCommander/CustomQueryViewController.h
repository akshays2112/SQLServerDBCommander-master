//
//  CustomQueryViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/18/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface CustomQueryViewController : UIViewController <UITextViewDelegate>

@property (nonatomic) Database *db;

@end
