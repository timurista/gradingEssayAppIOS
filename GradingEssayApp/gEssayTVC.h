//
//  gEssayTVC.h
//  GradingEssayApp
//
//  Created by Tim Urista on 5/1/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gEssay-Data.h"

@interface gEssayTVC : UITableViewController

@property (strong, nonatomic) NSArray* content;
@property (strong, nonatomic) gEssay_Data *model;
@end
