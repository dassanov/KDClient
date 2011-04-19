//
//  CrownViewController.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface CrownViewController : UITableViewController {
    
}

@property(nonatomic, retain) NSManagedObject *crown;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@end
