//
//  CustomQueryDataViewController.m
//  SQLServerDBCommander
//
//  Created by Akshay Srinivasan on 5/18/14.
//  Copyright (c) 2014 Akshay Srinivasan. All rights reserved.
//

#import "CustomQueryDataViewController.h"
#import "MMGridCell.h"
#import "MMTopRowCell.h"
#import "NSIndexPath+MMSpreadsheetView.h"

@interface CustomQueryDataViewController ()
@property (weak, nonatomic) IBOutlet UIView *subView;

@end

@implementation CustomQueryDataViewController {
    MMSpreadsheetView *spreadSheetView;
}


-(void) configure {
    if(self.data && self.data.count > 0 && self.data[0] && ((NSArray *)self.data[0]).count > 0) {
        if(!spreadSheetView) {
            spreadSheetView = [[MMSpreadsheetView alloc] initWithNumberOfHeaderRows:1 numberOfHeaderColumns:0 frame:self.view.bounds];
            [spreadSheetView registerCellClass:[MMGridCell class] forCellWithReuseIdentifier:@"GridCell"];
            [spreadSheetView registerCellClass:[MMTopRowCell class] forCellWithReuseIdentifier:@"TopRowCell"];
            spreadSheetView.delegate = self;
            spreadSheetView.dataSource = self;
            [self.subView addSubview:spreadSheetView];
        }
        [spreadSheetView reloadData];
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Data" message:@"There is no data in the table!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
    }
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

- (CGSize)spreadsheetView:(MMSpreadsheetView *)spreadsheetView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150.0, 50.0);
}

- (NSInteger)numberOfRowsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView {
    if(self.data && self.data.count > 0 && self.data[0] && ((NSArray *)self.data[0]).count > 0) {
        NSInteger rows = ((NSArray *)self.data[0]).count + 2;
        return rows;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfColumnsInSpreadsheetView:(MMSpreadsheetView *)spreadsheetView {
    if(self.data && self.data.count > 0 && self.data[0] && ((NSArray *)self.data[0]).count > 0 && ((NSArray *)self.data[0])[0]) {
        NSInteger cols = ((NSDictionary *)((NSArray *)self.data[0])[0]).allKeys.count;
        return cols;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)spreadsheetView:(MMSpreadsheetView *)spreadsheetView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    NSArray *keys = [((NSDictionary *)((NSArray *)self.data[0])[0]).allKeys sortedArrayUsingSelector:@selector(localizedCompare:)];
    if (indexPath.section == 0) {
        // Upper right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"TopRowCell" forIndexPath:indexPath];
        MMTopRowCell *tr = (MMTopRowCell *)cell;
        tr.textLabel.text = keys[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
    } else if(indexPath.mmSpreadsheetRow <= ((NSArray *)self.data[0]).count){
        // Lower right.
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMGridCell *gc = (MMGridCell *)cell;
        gc.textLabel.text = ((NSDictionary *)self.data[0][indexPath.mmSpreadsheetRow - 1])[keys[indexPath.mmSpreadsheetColumn]];
        BOOL isDarker = indexPath.mmSpreadsheetRow % 2 == 0;
        if (isDarker) {
            cell.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f];
            gc.textLabel.backgroundColor = [UIColor colorWithRed:242.0f / 255.0f green:242.0f / 255.0f blue:242.0f / 255.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
            gc.textLabel.backgroundColor = [UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
        }
    } else {
        cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
        MMGridCell *blankcell = (MMGridCell *) cell;
        blankcell.backgroundColor = [UIColor grayColor];
        blankcell.textLabel.text = @"";
        blankcell.textLabel.backgroundColor = [UIColor grayColor];
    }
    
    return cell;
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

@end
