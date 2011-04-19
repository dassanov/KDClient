//
//  KDClientTests.m
//  KDClientTests
//
//  Created by Tair Sabirgaliev on 02.04.11.
//  Copyright 2011 BEE Software. All rights reserved.
//

#import "KDClientTests.h"
#import "CrownListDelegate.h"


@implementation KDClientTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    CrownListDelegate *delegate = [[CrownListDelegate alloc] init];
    [delegate release];
    delegate = [[CrownListDelegate alloc] init];
    [delegate release];
    delegate = [[CrownListDelegate alloc] init];
    [delegate release];
//    STFail(@"Unit tests are not implemented yet in KDClientTests");
}

@end
