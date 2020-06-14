//
//  DataCollectionViewController.h
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/13/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSpreadsheetView.h"

@interface DataCollectionViewController : UIViewController <MMSpreadsheetViewDataSource, MMSpreadsheetViewDelegate>

@property (nonatomic) NSArray *data;

-(void) configure;

@end
