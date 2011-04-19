//
//  CrownCell.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 06.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "CrownCell.h"


@implementation CrownCell

@synthesize index=_index;
@synthesize report=_report;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        _index = NSIntegerMax;
    }
    return self;
}

-(void)useCrownAtIndex:(NSInteger)index ofReport:(NSManagedObject *)report {
    [_report release];
    _report = [report retain];
    
    NSArray *crowns = [_report valueForKey:@"crowns"];

    if (index < [crowns count]) {
        self.textLabel.text = @"Name";
        [self useField:@"name" ofManagedObject:[crowns objectAtIndex:index]];
    } else {
        _index = NSIntegerMax;
        self.textField.text = @"Add...";
    }
}

-(void)startEdit {
    if (_index == NSIntegerMax) {
        NSManagedObjectContext *context = [_report managedObjectContext];
        NSManagedObject *newCrown = [NSEntityDescription insertNewObjectForEntityForName:@"Crown" inManagedObjectContext:context];
        [newCrown setValue:_report forKey:@"report"];
    } else {
        [super startEdit];
    }
}

- (void)dealloc
{
    [_report release];
    [super dealloc];
}

@end
