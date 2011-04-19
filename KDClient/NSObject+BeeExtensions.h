//
//  NSObject+BeeExtensions.h
//  KDClient
//
//  Created by Tair Sabirgaliev on 30.03.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KDClientAppDelegate.h"

void dumpViews(UIView* view, NSString *text, NSString *indent);


@interface NSObject (BeeExtensions)
@property(nonatomic, readonly) KDClientAppDelegate *app;
@end
