//
//  GradingEssayAppTests.m
//  GradingEssayAppTests
//
//  Created by Tim Urista on 4/28/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssayFirstViewController.h"
#import "gEssay-Data.h"
#import <XCTest/XCTest.h>

@interface GradingEssayAppTests : XCTestCase

@end

@implementation GradingEssayAppTests

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDataNotNil {
    gEssay_Data* data = [gEssay_Data new];
    assert(data.data[0][0]>0);
}
-(void)testContentGetNotNil{
    gEssay_Data* data = [gEssay_Data new];
    NSArray *c =[data getContent];
    NSLog(@"%@",c);
    assert([c count]>0);
}
-(void)testGetContentNotNil{
    gEssay_Data* data = [gEssay_Data new];
    NSArray *c =[data getContent];
    NSArray *cat =[data getDataWithContentName:c[0]];
    assert([cat count]>0);
//    XCTFail(@"deliberate failure");
}
-(void) testGetCategoriesNotNil {
    gEssay_Data* data = [gEssay_Data new];
    NSArray *c =[data getContent];
    NSArray *cat =[data getDataWithContentName:c[0]];
    NSArray *subtitles = [data getCategoriesFromArray:cat];
    assert([subtitles count]>0);
}
@end
