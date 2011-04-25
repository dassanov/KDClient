//
//  CrownCell.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 06.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "UITableViewCell+BeeExtensions.h"

@class DetailViewController;

@interface CrownCell : UITableViewCell {
    
}

@property(nonatomic, retain) NSManagedObject *crown;
@property(nonatomic, assign) DetailViewController *detailViewController;

@end
