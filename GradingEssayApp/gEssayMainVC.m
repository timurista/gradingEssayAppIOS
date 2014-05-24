//
//  gEssayMainVC.m
//  GradingEssayApp
//
//  Created by Tim Urista on 5/5/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssayMainVC.h"
#import "gEssay-Data.h"
@interface gEssayMainVC ()

@end

@implementation gEssayMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    gEssay_Data* data = [gEssay_Data new];
    NSDictionary* gradeDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"gradeDict"];
    NSLog(@"gradeDict %@",gradeDict);
    if (!gradeDict) {
        gradeDict = [data getGradeDict];
    }
}

@end
