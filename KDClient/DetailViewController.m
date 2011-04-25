//
//  DetailViewController.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 02.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "NSObject+BeeExtensions.h"
#import "UITableViewCell+BeeExtensions.h"
#import "KDClientAppDelegate.h"
#import "CrownController.h"
#import "DetailViewController+CellSupport.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@property (nonatomic, copy) NSIndexPath *prevCellIndex;
@end

@implementation DetailViewController

@synthesize toolbar=_toolbar;
@synthesize tableView=_tableView;

@synthesize detailItem=_detailItem;

@synthesize popoverController=_myPopoverController;

@synthesize rootViewController=_rootViewController;

@synthesize outboxBarItem=_outboxBarItem;
@synthesize draftsBarItem=_draftsBarItem;
@synthesize trashBarItem=_trashBarItem;

@synthesize prevCellIndex=_prevCellIndex;
@synthesize crownController=_crownController;
@synthesize crownsSectionIndex;

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSManagedObject *)managedObject
{
	if (_detailItem != managedObject) {
		[_detailItem release];
		_detailItem = [managedObject retain];

        self.crownController = [[[CrownController alloc] initWithController:self] autorelease];
        
        // Update the view.
        [self configureView];
	}
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    self.draftsBarItem.enabled = NO;
    self.outboxBarItem.enabled = NO;
    self.trashBarItem.enabled = NO;
    if (self.detailItem != nil) {
        NSString *box = [self.detailItem valueForKey:@"box"];
        if ([box isEqualToString:@"draft"]) {
            self.outboxBarItem.enabled = YES;
            self.trashBarItem.enabled = YES;
//            [self.tableView setEditing:YES animated:YES];
        } else if ([box isEqualToString:@"outbox"]) {
            self.draftsBarItem.enabled = YES;
            self.trashBarItem.enabled = YES;
//            [self.tableView setEditing:NO animated:YES];
        } else if ([box isEqualToString:@"sent"]) {
            // TODO check status button
//            [self.tableView setEditing:NO animated:YES];
        } else if ([box isEqualToString:@"trash"]) {
            self.draftsBarItem.enabled = YES;
            self.outboxBarItem.enabled = YES;
//            [self.tableView setEditing:NO animated:YES];
        }
    }
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Events";
    self.popoverController = pc;
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popoverController = nil;

    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
        
}

- (void)splitViewController:(UISplitViewController*)svc popoverController:(UIPopoverController*)pc willPresentViewController:(UIViewController *)aViewController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}

#pragma mark -
#pragma mark Toolbar items actions

- (void) moveReport:(NSManagedObject *)report to:(NSString *)newBox  {
    assert(![[report valueForKey: @"box"] isEqual: newBox]);
    
    [report setValue:newBox forKey:@"box"];
    
    [self.app saveContext];
}

- (IBAction)moveToDrafts:(id)sender {
    [self moveReport:self.detailItem to:@"draft"];
    
    NSManagedObject *object = [self.detailItem retain];
    [self setDetailItem:nil];
    [self setDetailItem:object];
    [object release];
}

- (IBAction)moveToOutbox:(id)sender {
    [self moveReport:self.detailItem to:@"outbox"];
    
    [self setDetailItem:nil];
}

- (IBAction)moveToTrash:(id)sender {
    [self moveReport:self.detailItem to:@"trash"];
    
    [self setDetailItem:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.detailItem) {
        return [[self.app.uiInfo objectForKey:@"Report"] count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionInfo = [[self.app.uiInfo objectForKey:@"Report"] objectAtIndex:section];
    if ([[sectionInfo objectForKey:@"type"] isEqual:@"list"]) {
        NSInteger result = 0;
        NSString *field = [sectionInfo objectForKey:@"field"];
        if ([field isEqualToString:@"crowns"]) {
            self.crownsSectionIndex = section;
            NSArray *crowns = self.crownController.fetchedObjects;
            if (crowns) {
                result = [crowns count];
            }
        }
        
        if ([[self.detailItem valueForKey:@"box"] isEqual:@"draft"]) {
            result += 1;
        }
        return result;
    } else {
        return [[sectionInfo objectForKey:@"cells"] count];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.app.uiInfo objectForKey:@"Report"] objectAtIndex:section] objectForKey:@"label"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
    NSDictionary *sectionInfo = [[self.app.uiInfo objectForKey:@"Report"] objectAtIndex:indexPath.section];
    NSString *sectionType = [sectionInfo objectForKey:@"type"];
    if ([sectionType isEqual:@"list"]) {
        NSString *field = [sectionInfo objectForKey:@"field"];
        if ([field isEqualToString:@"crowns"]) {
            cell = [self tableView:tableView crownCellWithInfo:nil indexPath:indexPath];
        }
    } else {
        NSDictionary *cellInfo = [[sectionInfo objectForKey:@"cells"] objectAtIndex:indexPath.row];
    
        NSString *type = [cellInfo objectForKey:@"type"];
    
        if ([type isEqual:@"text"]) {
            cell = [self tableView:tableView editingCellWithInfo:cellInfo indexPath:indexPath];
        } else if ([type isEqual:@"dictionary"]) {
            cell = [self tableView:tableView selectOneCellWithInfo:cellInfo indexPath:indexPath];
        } else if ([type isEqual:@"plain"]) {
            cell = [self tableView:tableView plainCellWithInfo:cellInfo indexPath:indexPath];
        } else {
            NSLog(@"cell type '%@' is unknown!", type);
        }
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    NSDictionary *sectionInfo = [[self.app.uiInfo objectForKey:@"Report"] objectAtIndex:indexPath.section];
    NSString *sectionType = [sectionInfo objectForKey:@"type"];
    if ([sectionType isEqual:@"list"]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Table view delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
    
    if (indexPath.row < [self.crownController.fetchedObjects count]) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell isActive] && [self.tableView endEditing:NO]) {
        [cell setActive:YES];
    } else {
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.crownController deleteCrownAtIndex:indexPath.row];
}

#pragma mark - Memory management

- (void)dealloc
{
    [_crownController release];
    [_myPopoverController release];
    [_toolbar release];
    [_detailItem release];
    [super dealloc];
}

@end
