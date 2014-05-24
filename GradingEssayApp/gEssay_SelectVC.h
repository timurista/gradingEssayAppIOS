//
//  gEssay_SelectVC.h
//  GradingEssayApp
//
//  Created by Tim Urista on 5/2/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gEssay_SelectVC : UIViewController
@property (strong, nonatomic) NSArray* comments;
@property (strong, nonatomic) NSString* h1;
@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segController;
-(void) setH1:(NSString *)h1;
- (IBAction)ChangeText:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *selectedText;
@property (strong, nonatomic) IBOutlet UILabel *headingLabel;
- (IBAction)saveComment:(id)sender;
@property (strong, nonatomic) NSString* thisContent;
@end
