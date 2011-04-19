//
//  CrownViewController.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "CrownViewController.h"


@implementation CrownViewController

@synthesize crown=_crown;

#pragma mark - Navigation bar item actions

-(IBAction)save:(id)sender {
    
}

-(IBAction)cancel:(id)sender {
    
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

- (void)dealloc
{
    [_crown release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data

@end
