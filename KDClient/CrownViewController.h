//
//  CrownViewController.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class CrownViewController;

@protocol CrownViewDelegate 

-(void)controller:(CrownViewController *)controller didReturnWithSave:(BOOL)save;

@end

@interface CrownViewController : UITableViewController {
    
}

@property(nonatomic, assign) id<CrownViewDelegate> delegate;
@property(nonatomic, retain) NSManagedObject *crown;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *cancelItem;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *saveItem;

- (id)initWithCrown:(NSManagedObject *)crown;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@end
