//
//  CustomQueryViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/18/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "CustomQueryViewController.h"
#import "CustomQueryDataViewController.h"

@interface CustomQueryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *customQueryTextView;

@end

@implementation CustomQueryViewController

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CustomQueryDataViewController *vc = segue.destinationViewController;
    self.db.queryVC = vc;
    self.db.customQuery = self.customQueryTextView.text;
    [self.db fetchCustomQueryData];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.customQueryTextView resignFirstResponder];
        return FALSE;
    }
    return TRUE;
}

@end
