//
//  ObjDetailsTableViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "ObjDetailsTableViewController.h"
#import "Column.h"
#import "DataCollectionViewController.h"
#import "ForeignKey.h"
#import "ForeignKeyDetailsTableViewController.h"

@interface ObjDetailsTableViewController ()

@end

@implementation ObjDetailsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if([self.dbobj.xtype isEqualToString:@"U"]) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) {
        if([self.dbobj.xtype isEqualToString:@"U"]) {
            return self.dbobj.tablecolumns.count;
        } else if([self.dbobj.xtype isEqualToString:@"V"]) {
            return self.dbobj.viewcolumns.count;
        }
    } else {
        return self.dbobj.foreignKeys.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
        if([self.dbobj.xtype isEqualToString:@"U"]) {
            Column *col = self.dbobj.tablecolumns[indexPath.row];
            cell.textLabel.text = col.name;
            cell.detailTextLabel.text = [self getCellDetailText: col];
        } else if([self.dbobj.xtype isEqualToString:@"V"]) {
            Column *col = self.dbobj.viewcolumns[indexPath.row];
            cell.textLabel.text = col.name;
            cell.detailTextLabel.text = [self getCellDetailText: col];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FKCell" forIndexPath:indexPath];
        
        cell.textLabel.text = ((ForeignKey *)self.dbobj.foreignKeys[indexPath.row]).constraintName;
        
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Columns";
    } else {
        return @"Foreign Key Constraints";
    }
}

-(NSString *) getCellDetailText:(Column *)col {
    NSMutableString *detail = [[NSMutableString alloc] init];
    NSInteger collength = [col.collength integerValue];
    [detail appendString:([col.ispk isEqualToString:@"1"] ? @"PK, " : @"")];
    NSString *nullable = ([col.isnullable isEqualToString:@"1"] ? @"NULL" : @"NOT NULL");
    if([[col.coltypename lowercaseString] isEqualToString:@"nvarchar"] ||
       [[col.coltypename lowercaseString] isEqualToString:@"nchar"]) {
        [detail appendFormat:@"%@(%@), %@", col.coltypename, (collength == -1 ? @"MAX" : [NSNumber numberWithInt:(int)(collength / 2)]), nullable];
        return [NSString stringWithString:detail];
    } else if([[col.coltypename lowercaseString] isEqualToString:@"char"] ||
              [[col.coltypename lowercaseString] isEqualToString:@"varchar"] ||
              [[col.coltypename lowercaseString] isEqualToString:@"binary"] ||
              [[col.coltypename lowercaseString] isEqualToString:@"varbinary"]) {
        [detail appendFormat:@"%@(%@), %@", col.coltypename, (collength == -1 ? @"MAX" : [NSNumber numberWithInt:(int)collength]), nullable];
        return [NSString stringWithString:detail];
    } else {
        [detail appendFormat: @"%@, %@", col.coltypename, nullable];
        return [NSString stringWithString:detail];
    }
    return [NSString stringWithString:detail];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"FKDetails"]) {
        ForeignKeyDetailsTableViewController *vc = [segue destinationViewController];
        vc.fkobj = (ForeignKey *) self.dbobj.foreignKeys[[self.tableView indexPathForSelectedRow].row];
        [vc.tableView reloadData];
    } else {
        DataCollectionViewController *vc = [segue destinationViewController];
        self.dbobj.dataVC = vc;
        [self.dbobj fetchData];
    }
}

@end
