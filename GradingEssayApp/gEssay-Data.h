//
//  gEssay-Data.h
//  GradingEssayApp
//
//  Created by Tim Urista on 5/1/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gEssay_Data : NSObject

-(void) setData:(NSArray *)array;
-(NSArray *) data;
-(NSArray *) getContent;
-(NSArray *) getAllContent;
-(NSArray *) getDataWithContentName:(NSString *)content;
-(NSArray *) getCategoriesFromArray:(NSArray *)array;
-(NSArray *) getArrayInCategory:(NSString *)category fromArray:(NSArray *)array;
-(NSDictionary *) getGradeDict;
@end
