//
//  DatabaseObjectsTableViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "DatabaseObjectsTableViewController.h"
#import "DatabaseObject.h"
#import "ObjDetailsTableViewController.h"
#import "SPViewController.h"
#import "CustomQueryViewController.h"

@interface DatabaseObjectsTableViewController ()

@end

@implementation DatabaseObjectsTableViewController

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) {
        return self.db.usertables.count;
    } else if(section == 1) {
        return self.db.userviews.count;
    } else {
        return self.db.userprocs.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        cell.textLabel.text = ((DatabaseObject *)self.db.usertables[indexPath.row]).name;
        cell.imageView.image = [UIImage imageNamed:@"UserTable"];
    } else if(indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        cell.textLabel.text = ((DatabaseObject *)self.db.userviews[indexPath.row]).name;
        cell.imageView.image = [UIImage imageNamed:@"UserView"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SPCell" forIndexPath:indexPath];
        
        cell.textLabel.text = ((DatabaseObject *)self.db.userprocs[indexPath.row]).name;
        cell.imageView.image = [UIImage imageNamed:@"StoredProc"];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"User Tables";
    } else if(section == 1) {
        return @"User Views";
    } else {
        return @"User Stored Procedures";
    }
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
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    if([segue.identifier isEqualToString:@"TableViewsSegue"] == YES) {
        if(ip.section == 0 || ip.section == 1) {
            ObjDetailsTableViewController *vc = [segue destinationViewController];
            if(ip.section == 0) {
                DatabaseObject *dbobj = self.db.usertables[ip.row];
                vc.dbobj = dbobj;
                dbobj.dbobjdetailsTableView = vc.tableView;
                [dbobj fetchDetails];
            } else if(ip.section == 1) {
                DatabaseObject *dbobj = self.db.userviews[ip.row];
                vc.dbobj = dbobj;
                dbobj.dbobjdetailsTableView = vc.tableView;
                [dbobj fetchDetails];
            }
        }
    } else if([segue.identifier isEqualToString:@"CustomQuery"]) {
        CustomQueryViewController *vc = segue.destinationViewController;
        if(ip.section == 0) {
            vc.db = self.db;
        } else {
            vc.db = self.db;
        }
    } else {
        SPViewController *vc = [segue destinationViewController];
        DatabaseObject *dbobj = self.db.userprocs[ip.row];
        vc.dbobj = dbobj;
        dbobj.storecProcVC = vc;
        [dbobj fetchDetails];
    }
}

@end

