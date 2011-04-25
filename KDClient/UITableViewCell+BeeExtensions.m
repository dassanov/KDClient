//
//  UITableViewCell+BeeExtensions.m
//  KDClient
//
//  Created by Tair Sabirgaliev on 23.03.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "UITableViewCell+BeeExtensions.h"


@implementation UITableViewCell (BeeExtensions) 

- (BOOL)isActive 
{
    NSLog(@"UITableViewCell isActive");
    return NO;
}

- (void)setActive:(BOOL)active
{
    NSLog(@"UITableViewCell setActive: %@", active ? @"YES" : @"NO");
}

@end
