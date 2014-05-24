//
//  gEssayReviewVC.m
//  GradingEssayApp
//
//  Created by Tim Urista on 5/3/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssayReviewVC.h"

@interface gEssayReviewVC ()

@end

@implementation gEssayReviewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadcomments];

    //text accessor
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:__commentsTV action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    __commentsTV.inputAccessoryView = toolbar;
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [self loadcomments];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) loadcomments {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* Comments = [self setCommentsString:userDefaults];
    NSString* Grade = [self setGradeString:userDefaults];
    __commentsTV.text = [NSString stringWithFormat:@"%@\n\n%@",Comments,Grade];
}

-(NSString *) setCommentsString:(NSUserDefaults* ) userDefaults {
    NSString* Comments = @"Comments\n==============\n";
    NSDictionary* CommentsDict = [userDefaults objectForKey:@"CommentsDict"];
    for(id key in CommentsDict) {
        Comments = [NSString stringWithFormat: @"%@%@\n%@\n\n",Comments,key,CommentsDict[key]];
    }
    return Comments;
}

//handle keyboard
-(NSString *) setGradeString:(NSUserDefaults *)userDefaults {
    NSString* Grade = @"Grade\n=============\n";
    NSDictionary* gradeDict = [userDefaults objectForKey:@"gradeDict"];
    int totalPossible = [[userDefaults objectForKey:@"totalPossible"] intValue];
    int total = 0;
    for(id key in gradeDict) {
        Grade = [NSString stringWithFormat: @"%@\n%@: %@",Grade,key,gradeDict[key]];
        total = total + [gradeDict[key] intValue];
    }
    NSString *percentGrade = [NSString stringWithFormat:@"%0.1f%%",(total/(float)totalPossible)*100];
    
    Grade = [NSString stringWithFormat: @"%@\nTOTAL: %@ %d/%d",Grade,percentGrade,total,totalPossible];
    return Grade;
}

- (IBAction)copyToClipboard:(id)sender {
    
    //gen comments
    NSString *copyText = __commentsTV.text;
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:copyText];
    
    
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Copied to Clipboard"
                                                       message:copyText
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil];
    [theAlert show];
}
@end
