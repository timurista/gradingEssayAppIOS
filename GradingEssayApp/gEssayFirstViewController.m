//
//  gEssayFirstViewController.m
//  GradingEssayApp
//
//  Created by Tim Urista on 4/28/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssayFirstViewController.h"
#import "gEssayTVC.h"
@interface gEssayFirstViewController ()

@end

@implementation gEssayFirstViewController
    NSTimer* timer;
- (void)viewDidLoad
{
    
    [super viewDidLoad];

    //dummy text to test
    self.essayTV.text=@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Fusce vulputate eleifend sapien. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Nullam accumsan lorem in dui. Cras ultricies mi eu turpis hendrerit fringilla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In ac dui quis mi consectetuer lacinia. Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui. Aenean ut eros et nisl sagittis vestibulum. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede. Sed lectus. Donec mollis hendrerit risus. Phasellus nec sem in justo pellentesque facilisis. Etiam imperdiet imperdiet orci. Nunc nec neque. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Maecenas malesuada. Praesent congue erat at massa. Sed cursus turpis vitae tortor. Donec posuere vulputate arcu. Phasellus accumsan cursus velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed aliquam, nisi quis porttitor congue, elit erat euismod orci, ac";
    _essayTV.text = [UIPasteboard generalPasteboard].string;

    //check user comments not reset
    NSString *comments = [[NSUserDefaults standardUserDefaults] valueForKey:@"Comments"];
    if (comments.length<1) {
        [self resetComments];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scrollNow:(id)sender {
//    CGFloat maxOffsetHeight = self.sv.contentSize.height - CGRectGetHeight(self.sv.frame);
    if (!timer) {
        [self startTimer];
    }
    [self scroller];

}

-(void) scroller {

    CGFloat maxOffsetHeight1 = self.sv.contentSize.height - CGRectGetHeight(self.sv.frame);
    CGFloat textOffset = 5;
//    self.essayTV.font.capHeight+5;
    

    if (self.sv.contentOffset.y<maxOffsetHeight1) {
        [self.sv setContentOffset:CGPointMake(0, self.sv.contentOffset.y+textOffset) animated:YES];
    } else{
        //optional for resetting size of window
        //[self.sv setContentOffset:CGPointMake(0, maxOffsetHeight1)];
    }
//    //break string into chunks
//    NSArray *chunks = [_essayTV.text componentsSeparatedByString: @". "];
//    NSMutableArray *newChunks = [NSMutableArray arrayWithArray:chunks];
//    
//    //choose the index based on if text is visible
//    CGFloat offset = self.sv.contentOffset.y;
//    CGFloat size = (textOffset*[chunks count]);
//    int i = (int) (.25*(offset/textOffset));
////    i = i+([newChunks[i] count]>10)
//    NSArray *subarray = [newChunks subarrayWithRange:NSMakeRange(i, i)];
//    NSString *text = [subarray componentsJoinedByString:@". "];
//    //apply styling to current


}


#pragma mark -Timer
- (void) startTimer
{
    [self stopTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval: .5
                                             target: self
                                           selector:@selector(scroller)
                                           userInfo: nil repeats:YES];
}

- (void) stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
}

-(void) selectText:(NSString *)text {
//    //reset bg colors
//    NSRange range1 = NSMakeRange(0, _essayTV.text.length);
//    [self applyBGColortoSelection:NO range:range1];
//
    //1. gets range from the text to select
//    NSRange range = [_essayTV.text rangeOfString:text];
//    NSRange range = [_essayTV selectedRange];
}

-(void)applyBGColortoSelection:(BOOL)selected range:(NSRange)range{
    // 2. Create a new font with the selected text style.
    UIColor *color = [UIColor whiteColor];
    if (selected) {
     color = [UIColor yellowColor];
    }
    
    // 3. Begin editing the text storage.
    [_essayTV.textStorage beginEditing];
    
    // 4. Create a dictionary with the new font as the value and the NSFontAttributeName property as a key.
    NSDictionary *dict = @{NSBackgroundColorAttributeName: color};
    
    // 5. Set the new attributes to the text storage object of the selected text.
    [_essayTV.textStorage setAttributes:dict range:range];
    
    // 6. Notify that we end editing the text storage.
    [_essayTV.textStorage endEditing];
    
    
}

- (IBAction)reset:(id)sender {
    NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
}
#pragma-mark Alert and Handling Error Example
- (IBAction)addError:(id)sender {
    NSRange range = [_essayTV selectedRange];
    if (range.length>0) {
        NSString *selectedText = [_essayTV.text substringWithRange:range];
        NSString *message = [NSString stringWithFormat:@"Error example in your paper: \"%@...\"",selectedText];
        
        [self applyBGColortoSelection:YES range:[_essayTV selectedRange]];
        
        //save message to default
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:message
                         forKey:@"exampleError"];
        
        //alert user
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Error Example"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Save Error",nil];
        [theAlert show];
        
    }
    [self stopTimer];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Save Error"])
    {
        NSLog(@"Saving...");

        [self performSegueWithIdentifier:@"tableSegue" sender:self];
    }
    else if([title isEqualToString:@"Button 2"])
    {
        NSLog(@"Button 2 was selected.");
    }

}
-(void)prepareForSegue:(NSString *)segue sender:(id)sender{

}

-(void) resetComments {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"Comments\n===============\n" forKey:@"Comments"];

}
@end
