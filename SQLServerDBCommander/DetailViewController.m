//
//  DetailViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        [self.databasesTableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return ((SQLServer *)self.detailItem).systemDBs.count;
    } else {
        return ((SQLServer *)self.detailItem).userDBs.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"System Databases";
    } else {
        return @"User Databases";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(indexPath.section == 0) {
        cell.textLabel.text = ((Database *)(((SQLServer *)self.detailItem).systemDBs[indexPath.row])).name;
        cell.imageView.image = [UIImage imageNamed:@"SysDatabase"];
    } else {
        cell.textLabel.text = ((Database *)(((SQLServer *)self.detailItem).userDBs[indexPath.row])).name;
        cell.imageView.image = [UIImage imageNamed:@"Database"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DBObjs"]) {
        DatabaseObjectsTableViewController *vc = segue.destinationViewController;
        NSIndexPath *ip = [self.databasesTableView indexPathForSelectedRow];
        if(ip.section == 0) {
            Database *sysdb = ((SQLServer *)self.detailItem).systemDBs[ip.row];
            vc.db = sysdb;
            sysdb.dbobjsTableView = vc.tableView;
            [sysdb fetchDBObjects];
        } else {
            Database *userdb = ((SQLServer *)self.detailItem).userDBs[ip.row];
            vc.db = userdb;
            userdb.dbobjsTableView = vc.tableView;
            [userdb fetchDBObjects];
        }
    }
}

@end
