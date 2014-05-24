//
//  gEssaySecondViewController.h
//  GradingEssayApp
//
//  Created by Tim Urista on 4/28/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gEssaySecondViewController : UIViewController
- (IBAction)copyToClipboard:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *mainSV;
@property (strong, nonatomic) IBOutlet UILabel *gradeTV;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) IBOutlet UILabel *outOfScore;
@property (strong, nonatomic) NSDictionary *gradeDict;
- (IBAction)changeTotal:(id)sender;
@end
