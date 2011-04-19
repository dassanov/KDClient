//
//  DetailViewController.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 02.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@class RootViewController;
@class CrownController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {

}


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSManagedObject *detailItem;

@property (nonatomic, assign) IBOutlet RootViewController *rootViewController;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *outboxBarItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *draftsBarItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *trashBarItem;

@property (nonatomic, retain) CrownController *crownController;
@property (nonatomic, assign) NSInteger crownsSectionIndex;

- (IBAction)moveToDrafts:(id)sender;
- (IBAction)moveToOutbox:(id)sender;
- (IBAction)moveToTrash:(id)sender;

@end
