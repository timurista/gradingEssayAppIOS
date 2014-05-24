//
//  gEssay_SelectVC.m
//  GradingEssayApp
//
//  Created by Tim Urista on 5/2/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssay_SelectVC.h"

@interface gEssay_SelectVC ()

@end

@implementation gEssay_SelectVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setH1:(NSString *)h1 {
    _h1 = h1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSelectionOptions];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadSelectionOptions {
    //prepare Index
    [_segController removeSegmentAtIndex:0 animated:NO];
    [_segController removeSegmentAtIndex:0 animated:NO];
    for (NSUInteger i=0;i<[_comments count]; i++) {
        [_segController insertSegmentWithTitle:[NSString stringWithFormat:@"%d",i] atIndex:i animated:YES];
    }
    //heading
    _headingLabel.text = self.h1;
    _segController.selectedSegmentIndex=0;
    [self updateSelection];
    
}

-(void) updateSelection {
    _selectedText.text = [NSString stringWithFormat:@"%@ %@.",_comments[_segController.selectedSegmentIndex],
                          [[NSUserDefaults standardUserDefaults] objectForKey:@"exampleError"]];
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

- (IBAction)ChangeText:(id)sender {
    [self updateSelection];
    
}

- (IBAction)saveComment:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* Comments = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:@"CommentsDict"]];
    NSString* currentComments = Comments[_category];
    
    if  ([Comments count] == 0 ) {
        Comments = [NSMutableDictionary dictionaryWithObject:_selectedText.text forKey:_category];
    }
    else if (currentComments == (id)[NSNull null] || currentComments.length == 0 ) {
        Comments[_category] = _selectedText.text;
//        [Comments setObject:_selectedText.text forKey:_category];
    }
    else {
        Comments[_category] = [NSString stringWithFormat:@"%@ %@",currentComments,_selectedText.text];
        [userDefaults setObject:Comments
                         forKey:@"CommentsDict"];
    }
    
    [userDefaults setObject:[NSDictionary dictionaryWithDictionary:Comments]
                     forKey:@"CommentsDict"];
    Comments = [userDefaults objectForKey:@"CommentsDict"];
    NSLog(@"%@",Comments);
    
    //adjust grade
    
    NSMutableDictionary* gradeDict = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:@"gradeDict"]];
    NSUInteger countOfItems = [gradeDict count];
    NSUInteger totalPts = [[userDefaults valueForKey:@"totalPossible"] intValue];
    CGFloat gradeDecrement = (totalPts/countOfItems)*.1;
    NSInteger decreaseGrade = gradeDecrement+0.5f;
    NSInteger currentGrade = [gradeDict[_category] intValue];
    [gradeDict setValue:[NSNumber numberWithInt:currentGrade-decreaseGrade] forKey:_category];
    //saveToPrefs
    NSLog(@"adjusting grade...");
    [userDefaults setObject:[NSDictionary dictionaryWithDictionary:gradeDict] forKey:@"gradeDict"];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    

}
@end
