//
//  gEssay_CategoryTVC.h
//  GradingEssayApp
//
//  Created by Tim Urista on 5/2/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gEssay-Data.h"

@interface gEssay_CategoryTVC : UITableViewController

@property (strong, nonatomic) NSArray* content;
@property (strong, nonatomic) gEssay_Data *model;
-(void) setCategory:(NSString *)category;
@property (strong, nonatomic) NSString* thisCategory;
@property (strong, nonatomic) NSArray* categories;
@end
