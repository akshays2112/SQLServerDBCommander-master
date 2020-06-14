//
//  AddSQLServerViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/12/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "AddSQLServerViewController.h"

@interface AddSQLServerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *sqlServerName;
@property (weak, nonatomic) IBOutlet UITextField *sqlServerPortNumber;
@property (weak, nonatomic) IBOutlet UITextField *sqlServerUserName;
@property (weak, nonatomic) IBOutlet UITextField *sqlServerPassword;

@end

@implementation AddSQLServerViewController

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addSqlServer:(id)sender {
    if(self.sqlServerName.text == nil || [self.sqlServerName.text isEqualToString:@""] || self.sqlServerName.text.length == 0) {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"SQL Server address has to be provided" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [v show];
        return;
    }
    if(self.sqlServerPortNumber.text == nil || [self.sqlServerPortNumber.text isEqualToString:@""] || self.sqlServerPortNumber.text.length == 0) {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"SQL Server port has to be provided" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [v show];
        return;
    }
    if(self.sqlServerUserName.text == nil || [self.sqlServerUserName.text isEqualToString:@""] || self.sqlServerUserName.text.length == 0) {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Error" message:@"SQL Server port has to be provided" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [v show];
        return;
    }
    SQLServer *svr = [[SQLServer alloc] init];
    svr.name = self.sqlServerName.text;
    svr.port = self.sqlServerPortNumber.text;
    svr.username = self.sqlServerUserName.text;
    svr.password = self.sqlServerPassword.text;
    [self.servers addObject:svr];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.svrtv reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
