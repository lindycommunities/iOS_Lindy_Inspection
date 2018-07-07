//
//  DatePickerViewController.m
//  iGIIS
//
//  Created by GIR Technologey Pvt.Ltd on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"

#define Date_Picker_Title @"Select Date"//NSLocalizedString(@"SelectDate", @"SelectDate") 

@implementation DatePickerViewController

@synthesize datePicker = _datePicker;
@synthesize isPickerVisible = _isPickerVisible;
@synthesize delegate;// = _delegate;
@synthesize lblHeading=_lblHeading;
@synthesize lblDateDisplay=_lblDateDisplay;
@synthesize isTimeView;
@synthesize str_selectedDate=_str_selectedDate;

int initFlag;

-(void)dealloc{
    [super dealloc];
}

#pragma mark init with minimum date 
-(id)initWithTodayAsMinimumDate{
    
//    [self.datePicker setMinimumDate:[NSDate date]];
    initFlag = 1;
    return self; 
}

#pragma mark default init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWith:(NSString *)selectedValue
{
//    initFlag = 1;
    NSLog(@"selected value %@", selectedValue);
    str_selectedDate=selectedValue;
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.lblHeading setHidden:YES];
    [self.lblDateDisplay setHidden:YES];
    
    //add done btn to navigation bar
    UIBarButtonItem *rightBarDoneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarDoneBtn;
    [rightBarDoneBtn release];
    
    //add cancel btn if user dont want to add any date
    UIBarButtonItem *leftBarCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnClicked:)];
    self.navigationItem.leftBarButtonItem = leftBarCancel;
    [leftBarCancel release];
    
    if(initFlag == 1)
    {
        [self.datePicker setMinimumDate:[NSDate date]];
    }  
    else
    {
        if (![str_selectedDate length] == 0)
        {
            NSString *string=str_selectedDate;
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat:@"dd - MM - yyyy"];
            NSDate *dateFromString = [dateFormatter dateFromString:string];
            [self.datePicker setDate:dateFromString];
            
        }
            NSDate *selected=[NSDate date];
            NSLog(@"Date %@",selected);
            NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
            [formatter setDateFormat:@"dd - MM - yyyy"];
            NSString *str1 = [formatter stringFromDate:selected];
            self.lblDateDisplay.text=[NSString stringWithFormat:@"%@",str1];
    }
    //set datepicer to center of frame
    CGRect frame = self.datePicker.frame;
    frame.origin.y = 150;
    self.datePicker.frame = frame;
    
    
    if(self.isTimeView){
        
        self.datePicker.datePickerMode=UIDatePickerModeTime;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark handle done btn click event
-(IBAction)doneBtnClicked:(id)sender{
    [delegate DatePickerViewControllerDidFinish:self];
}

#pragma mark handle cancel btn click event
-(IBAction)cancelBtnClicked:(id)sender{
    [delegate DatePickerViewControllerDidCancel:self];
}
@end
