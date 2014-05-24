//
//  gEssaySecondViewController.m
//  GradingEssayApp
//
//  Created by Tim Urista on 4/28/14.
//  Copyright (c) 2014 Tim Urista. All rights reserved.
//

#import "gEssaySecondViewController.h"
#import "gEssay-Data.h"
@interface gEssaySecondViewController ()


@end

@implementation gEssaySecondViewController
NSUInteger totalPossible = 60;
NSUInteger sizeOfContents;
NSUInteger weight;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set constants
    sizeOfContents = [[[gEssay_Data new] getContent] count];
    totalPossible = [self.total.text integerValue];
    weight = [[[NSUserDefaults standardUserDefaults] valueForKey:@"gradeWeight"] intValue];
    _categories = [NSMutableArray new];
    [self loadGradeDict];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillDisappear:(BOOL)animated {
    [self saveToGradeDict];
    NSLog(@"Grade Dict Saved to: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"gradeDict"]);
    
}

-(void) viewWillAppear:(BOOL)animated {
    [self loadGradeDict];
}

-(void) loadContentViews:(NSDictionary *)gradeDict {
    //scroll view params
    _mainSV.scrollEnabled = YES;
    //make sure you set contentSize so it will scroll
    _mainSV.contentSize = CGSizeMake(_mainSV.frame.size.width, _mainSV.frame.size.height+60);
    _mainSV.showsVerticalScrollIndicator = YES;

    //handling subviews
    weight = 12;
    gEssay_Data* data = [gEssay_Data new];
    NSArray *content = data.getContent;
    NSUInteger spacingX = 120;
    NSUInteger spacingY = 60;
    NSUInteger paddingX = (_mainSV.frame.size.width - spacingX*2)/2;
    NSUInteger posX = paddingX;
    NSUInteger posY = 0;

    //createViews
    for (NSString *key in gradeDict) {
        NSUInteger value = [gradeDict[key] intValue];
        NSString *label = [NSString stringWithFormat:@"%d: %@",value,key];

        NSUInteger tag = [content indexOfObject:key];
        [self addSlideAndLabelToScrollView:label rect:CGRectMake(posX, posY, 100, 60) view:_mainSV tag:tag value:value];
        posY+= spacingY;
        if (posY>_mainSV.frame.size.height-spacingY) {
            posX +=spacingX;
            posY = 0;
        }
    }

}


//add to grade dict
-(void) saveToGradeDict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* gradeDict = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:@"gradeDict"]];
   
    for (NSNumber *n in _categories) {
        //slider save values
        NSUInteger SliderNum = [n integerValue]+1000;
        UISlider *slider = (UISlider *) [_mainSV viewWithTag:SliderNum];
        NSNumber* value = [NSNumber numberWithInt:slider.value];
        
        
        //save label
        NSUInteger labelTag = [n integerValue]+1100;
        UILabel *labelAbove = (UILabel *) [_mainSV viewWithTag:labelTag];
        NSUInteger val = slider.value;
        NSUInteger index = [NSString stringWithFormat:@"%d",val].length+2;
        NSString *key = [labelAbove.text substringFromIndex:index];
        key = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
        //write to gradeDict
        [gradeDict setObject:value forKey:key];
    }
    
    [userDefaults setObject:[NSDictionary dictionaryWithDictionary:gradeDict] forKey:@"gradeDict"];
    [userDefaults setObject:[NSNumber numberWithInt:totalPossible] forKey:@"totalPossible"];
}

-(void) loadGradeDict {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"loading grade dict");
        _gradeDict = [userDefaults valueForKey:@"gradeDict"];
    
    //in case not created
    if (!_gradeDict) {
        NSLog(@"creating new Dict");
        gEssay_Data* data = [gEssay_Data new];
        _gradeDict = [data getGradeDict];
    }
    [self loadContentViews:_gradeDict];
    [self UpdateLabelsForTotals];
    
    
}

-(void) addSlideAndLabelToScrollView:(NSString *)label rect:(CGRect)rect view:(UIView *)view tag:(NSUInteger)Tag value:(NSUInteger)value {
    NSUInteger sliderTag = 1000+Tag;
    NSUInteger labelTag = 1100+Tag;
    UISlider*  slider;
    UILabel* l;
    
    //slider
    //Create if no previous slider
    if ([_mainSV viewWithTag:sliderTag]) {
        slider = (UISlider*) [_mainSV viewWithTag:sliderTag];
        //update values of slider
    }
    else {
        CGRect sliderRect = CGRectOffset(rect, 0, 30);
        slider = [[UISlider alloc] initWithFrame:sliderRect];
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:slider];
        slider.tag=1000+Tag;
        slider.maximumValue = weight;
    }
    slider.value = value;

    //label
    //create if no previous label
    if ([_mainSV viewWithTag:labelTag]) {
        l = (UILabel*) [_mainSV viewWithTag:labelTag];
    }
    else {
        l = [[UILabel alloc] initWithFrame:rect];
        l.textAlignment =  NSTextAlignmentCenter;
        [view addSubview:l];
        [_categories addObject:[NSNumber numberWithInteger:Tag]];
        l.tag = 1100+Tag;
    }
    l.text = label;

    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSUInteger total = 0;
    NSArray *subsliders = [self listSubSlidersOfView:_mainSV];
    NSMutableDictionary *gradeDict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"gradeDict"]];
    
    for (UISlider *v in subsliders) {
        total+=v.value;
    }
    NSUInteger labelTag = sender.tag+100;
    UILabel *labelAbove = (UILabel *) [_mainSV viewWithTag:labelTag];
    NSUInteger val = sender.value;
    NSUInteger index = [NSString stringWithFormat:@"%d",val].length+2;
    
    NSString *txt = [labelAbove.text substringFromIndex:index];
    NSString* currentText = [NSString stringWithFormat:@"%d: %@",val,txt];
 
    labelAbove.text = currentText;
    
    
    _gradeTV.text = [NSString stringWithFormat:@"%0.1f%%", 100*(total/((float)totalPossible))];
    _gradeTV.textAlignment = NSTextAlignmentCenter;
    _score.text = [NSString stringWithFormat:@"%d",total];
    
    //make slider sticky
    NSUInteger stepValue = 0;
    stepValue = ceil(weight/10);
    sender.value = [self stickNumberToClosest:sender.value point:stepValue];
    
    //save gradeDict
//    gradeDict[key] = [NSNumber numberWithInt:sender.value];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionaryWithDictionary:gradeDict] forKey:@"gradeDict"];
    
    //save grades
    [[NSUserDefaults standardUserDefaults] setObject:[self generateGrade] forKey:@"Grade"];
//    [self saveToGradeDict];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    totalPossible = [textField.text integerValue];
    [self.view endEditing:YES];
    [textField resignFirstResponder];
}


-(NSString *)generateGrade {
    NSString* comments =@"Grade\n==========\n";
    NSUInteger total = 0;
    //update values in sliders
    for (NSNumber *n in _categories) {
        
        //slider change values
        NSUInteger SliderNum = [n integerValue]+1000;
        UISlider *slider = (UISlider *) [_mainSV viewWithTag:SliderNum];
        
        
        //change label
        NSUInteger labelTag = [n integerValue]+1100;
        UILabel *labelAbove = (UILabel *) [_mainSV viewWithTag:labelTag];
        NSUInteger val = slider.value;
        NSUInteger index = [NSString stringWithFormat:@"%d",val].length+2;
        NSString *txt = [labelAbove.text substringFromIndex:index];
        comments = [comments stringByAppendingFormat:@"%@: ",txt];
        
        //slider
        comments = [comments stringByAppendingString:
         [NSString stringWithFormat:@"%d\n",(int) slider.value]];
         
        //change current grade
        total+=slider.value;
    }
    comments = [comments stringByAppendingString:
     [NSString stringWithFormat:@"#########\n TOTAL: %@ \n %d/%d",_gradeTV.text,total,totalPossible ]];

    return comments;
}

#pragma-mark Helpers
- (NSArray *)listSubSlidersOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    NSMutableArray *subsliders = [NSMutableArray new];
    
    //add views if slider view
    for (UIView *v in subviews) {
        if ([v isKindOfClass:[UISlider class]]) {
            [subsliders addObject:v];
        }
    }
    
    // Return if there are no subviews
    if ([subviews count] == 0) return @[];
    
    //else return mutated array
    return [NSArray arrayWithArray:subsliders];
}

-(NSUInteger) generateTotalGrade {
    NSUInteger total=0;
    for (NSNumber *n in _categories) {
        //slider change values
        NSUInteger SliderNum = [n integerValue]+1000;
        UISlider *slider = (UISlider *) [_mainSV viewWithTag:SliderNum];
        
        //change current grade
        total+=slider.value;
    }
    return total;
}

- (void)UpdateLabelsForTotals {
    NSUInteger total = [self generateTotalGrade];
    _gradeTV.text = [NSString stringWithFormat:@"%0.1f%%", 100*(total/((float)totalPossible))];
    _outOfScore.text = [NSString stringWithFormat:@"%d",totalPossible];
    _score.text = [NSString stringWithFormat:@"%d",total];
}

- (IBAction)changeTotal:(id)sender {

//    stepper.value;
    UIStepper *s = sender;
    s.stepValue = 10;
    totalPossible = ceil(s.value);
    NSUInteger oldWeight = weight;
    weight = ceil(totalPossible/sizeOfContents);
    NSUInteger total = 0;
    
//    //update values in sliders
    for (NSNumber *n in _categories) {
        
        
        //slider change values
        NSUInteger SliderNum = [n integerValue]+1000;
        UISlider *slider = (UISlider *) [_mainSV viewWithTag:SliderNum];
        slider.maximumValue=weight;

        //calc new weight based on position of old weight
        CGFloat sliderWeight = weight*(slider.value/oldWeight);
        slider.value = ceil(sliderWeight);
//        NSLog(@"%d %f",weight,sliderWeight);
        
        
        //change label
        NSUInteger labelTag = [n integerValue]+1100;
        UILabel *labelAbove = (UILabel *) [_mainSV viewWithTag:labelTag];
        NSUInteger val = slider.value;
        NSUInteger index = [NSString stringWithFormat:@"%d",val].length+2;
        NSString *txt = [labelAbove.text substringFromIndex:index];
        NSString* currentText = [NSString stringWithFormat:@"%d: %@",val,txt];
        labelAbove.text = currentText;
        
        //change current grade
        total+=slider.value;
    }
    [self UpdateLabelsForTotals];


}

-(NSUInteger) stickNumberToClosest:(NSUInteger)number point:(NSUInteger)point {
    NSUInteger minPoint = point* (int) (number/point);
    NSUInteger maxPoint = minPoint+point;
    NSUInteger convertedNumber = (maxPoint-number<=number-minPoint)?maxPoint:minPoint;
    return convertedNumber;
}


- (IBAction)copyToClipboard:(id)sender {
    //gen comments
    NSString *copyText = [self generateGrade];
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:copyText];

    
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Copied to Clipboard"
                                                       message:copyText
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:nil];
    [theAlert show];
}

#pragma mark Old Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
