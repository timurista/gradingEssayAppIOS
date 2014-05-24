//
//  gEssayReviewVC.h
//  GradingEssayApp
//
//  Created by Tim Urista on 5/3/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gEssayReviewVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *_commentsTV;
- (IBAction)copyToClipboard:(id)sender;

@end
