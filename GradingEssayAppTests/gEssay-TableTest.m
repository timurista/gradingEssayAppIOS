//
//  gEssay-TableTest.m
//  GradingEssayApp
//
//  Created by Tim Urista on 5/2/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "gEssayTVC.h"

@interface gEssay_TableTest : XCTestCase

@end

@implementation gEssay_TableTest
gEssayTVC *tv;

- (void)setUp
{
    [super setUp];
    tv = [gEssayTVC new];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTableLoadsData
{
    assert(tv.class);
    
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
