//
//  SelectOneCell.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 18.03.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "SelectOneCell.h"
#import "SelectOneController.h"
#import "DetailViewController.h"
@interface SelectOneCell () <SelectOneDelegate>
@end

@implementation SelectOneCell

@synthesize detailViewController;

- (void)didCancel:(SelectOneController *)selectOneController {
    [self setActive:NO];
}

- (void)didAccept:(SelectOneController *)selectOneController {
    [self setActive:NO];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setActive:(BOOL)active {
    if (active && !_active) {
        SelectOneController *selectOneController = [[[SelectOneController alloc] initWithNibName:@"SelectOneController" bundle:nil] autorelease];
        selectOneController.key = @"driller";
        selectOneController.delegate = self;
        //	selectOneController.rows = [detailViewController.mockData objectForKey:@"drillers"];
        selectOneController.modalPresentationStyle = UIModalPresentationFormSheet;
        selectOneController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.detailViewController presentModalViewController:selectOneController animated:YES];
        _active = YES;
    } else if (!active && _active) {
        [self.detailViewController dismissModalViewControllerAnimated:YES];
        _active = NO;
    }
}

- (BOOL)isActive {
    return _active;
}

- (void)dealloc
{
    [super dealloc];
}

@end
