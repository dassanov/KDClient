//
//  CrownController.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 17.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "CrownController.h"
#import "DetailViewController.h"
#import "RootViewController.h"

@implementation CrownController

@synthesize detailViewController=_detailViewController;

-(id)initWithController:(DetailViewController *) aDetailViewController {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Crown" inManagedObjectContext:aDetailViewController.rootViewController.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:5];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [sortDescriptor release];
    [sortDescriptors release];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"report == %@", aDetailViewController.detailItem]];
    
    self = [super initWithFetchRequest:fetchRequest managedObjectContext:aDetailViewController.rootViewController.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [fetchRequest release];

    if (self) {
        self.delegate = self;
        self.detailViewController = aDetailViewController;
        
        NSError *error = nil;
        if (![self performFetch:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        return self;
    }

    return nil;
}

#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.detailViewController.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.detailViewController.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.detailViewController.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath 
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath 
{
    NSIndexPath *indexPath_ = [NSIndexPath indexPathForRow:indexPath.row inSection:self.detailViewController.crownsSectionIndex];
    NSIndexPath *newIndexPath_ = [NSIndexPath indexPathForRow:newIndexPath.row inSection:self.detailViewController.crownsSectionIndex];
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.detailViewController.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath_] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.detailViewController.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath_] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.detailViewController.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath_] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"NSFetchedResultsChangeMove");
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.detailViewController.tableView endUpdates];
}


@end
