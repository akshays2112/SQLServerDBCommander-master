//
//  SPViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseObject.h"

@interface SPViewController : UIViewController

@property (nonatomic) DatabaseObject *dbobj;
@property (nonatomic) NSString *spSourceCode;
@property (weak, nonatomic) IBOutlet UITextView *spSourceCodeTV;

-(void) configure;

@end
