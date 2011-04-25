//
//  CrownController.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 17.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface CrownController : NSFetchedResultsController <NSFetchedResultsControllerDelegate> {
}

@property(nonatomic, assign) DetailViewController *detailViewController;
-(id)initWithController:(DetailViewController *) detailViewController;
-(void)insertCrown;
-(void)deleteCrownAtIndex:(NSUInteger)index;

@end
