//
//  CrownCell.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 06.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "EditingCell.h"
#import <UIKit/UIKit.h>


@interface CrownCell : EditingCell {
    
}

@property(nonatomic, readonly) NSManagedObject *report;
@property(nonatomic, readonly) NSInteger index;

-(void)useCrownAtIndex:(NSInteger)index ofReport:(NSManagedObject *)report;

@end
