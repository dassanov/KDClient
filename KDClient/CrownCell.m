//
//  CrownCell.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 06.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "CrownCell.h"
#import "DetailViewController.h"
#import "CrownController.h"
#import "CrownViewController.h"

@interface CrownCell (Private) <CrownViewDelegate>
@end

@implementation CrownCell

@synthesize crown=_crown;
@synthesize detailViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.detailTextLabel.text = @"Добавить коронку";
    }
    return self;
}

- (void)controller:(CrownViewController *)controller didReturnWithSave:(BOOL)save {
    [self.detailViewController dismissModalViewControllerAnimated:YES];
    [self setSelected:NO animated:YES];
    [self setNeedsDisplay];
}

-(void)setCrown:(NSManagedObject *)crown {
    if (_crown != crown) {
        [_crown release];
        _crown = [crown retain];
        self.textLabel.text = @"Коронка";
        self.detailTextLabel.text = [_crown valueForKey:@"crownName"];
    }
    
}

-(BOOL)isActive {
    return NO;
}

-(void)setActive:(BOOL)active {
    if (self.crown) {
        CrownViewController *crownViewController = [[[CrownViewController alloc] initWithCrown:self.crown] autorelease];
        crownViewController.delegate = self;
        UINavigationController*  navigationController = [[[UINavigationController alloc]
                                                     initWithRootViewController:crownViewController] autorelease];
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.detailViewController presentModalViewController:navigationController animated:YES];
        [self setSelected:YES];
    } else {
        [self.detailViewController.crownController insertCrown];
    }
}

- (void)dealloc
{
    [_crown release];
    [super dealloc];
}

@end
