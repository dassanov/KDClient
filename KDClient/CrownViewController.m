//
//  CrownViewController.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "CrownViewController.h"
#import "EditingCell.h"
#import "NSObject+BeeExtensions.h"

@implementation CrownViewController

@synthesize crown=_crown;
@synthesize delegate;

@synthesize cancelItem=_cancelItem;
@synthesize saveItem=_saveItem;

#pragma mark - Navigation bar item actions

-(IBAction)save:(id)sender
{
    NSLog(@"save");
    [self.delegate controller:self didReturnWithSave:YES];
}

-(IBAction)cancel:(id)sender
{
    [self.delegate controller:self didReturnWithSave:NO];
}

#pragma mark Construction/Initialization

- (id)initWithCrown:(NSManagedObject *)crown
{
    self = [super initWithNibName:@"CrownView" bundle:nil];
    if (self) {
        _crown = [crown retain];
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationItem.leftBarButtonItem = self.cancelItem;
    self.navigationItem.rightBarButtonItem = self.saveItem;
}

- (void)dealloc
{
    [_crown release];
    [_cancelItem release];
    [_saveItem release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *sections = [self.app.uiInfo valueForKey:@"Crown"];
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [self.app.uiInfo valueForKey:@"Crown"];
    return [[[sections objectAtIndex:section] valueForKey:@"cells"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sections = [self.app.uiInfo valueForKey:@"Crown"];
    NSArray *cells = [[sections objectAtIndex: indexPath.section] valueForKey: @"cells"];
    NSDictionary *cellInfo = [cells objectAtIndex:indexPath.row];
    
	EditingCell *cell = [[[EditingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSString *label = [cellInfo valueForKey:@"label"];
    NSString *field = [cellInfo valueForKey:@"field"];
    [cell useField:field ofManagedObject:self.crown];
	cell.textLabel.text = label;
	return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isActive] && [self.tableView endEditing:NO]) {
        [cell setActive:YES];
    } else {
    }
}

@end
