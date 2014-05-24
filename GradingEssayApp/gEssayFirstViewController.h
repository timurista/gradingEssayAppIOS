//
//  gEssayFirstViewController.h
//  GradingEssayApp
//
//  Created by Tim Urista on 4/28/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gEssayFirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UITextView *essayTV;
@property (strong, nonatomic) IBOutlet UIButton *scrollB;

- (IBAction)scrollNow:(id)sender;
-(void) scroller;
- (IBAction)addError:(id)sender;
-(void)applyBGColortoSelection:(BOOL)selected range:(NSRange)range;
- (IBAction)reset:(id)sender;

@end
