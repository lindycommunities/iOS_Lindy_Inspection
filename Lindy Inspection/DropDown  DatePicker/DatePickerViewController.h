//
//  DatePickerViewController.h
//  iGIIS
//
//  Created by GIR Technologey Pvt.Ltd on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerViewController; //forward declearation of class

@protocol DatePickerViewControllerDelegate
@optional
- (void)DatePickerViewControllerDidFinish:(DatePickerViewController *)controller;
- (void)DatePickerViewControllerDidCancel:(DatePickerViewController *)controller;
@end

@interface DatePickerViewController : UIViewController {

	//    UIView  *dateView;
	IBOutlet UIDatePicker *datePicker;
	BOOL isPickerVisible;
	 id <DatePickerViewControllerDelegate> delegate;

//    IBOutlet UILabel *lblBgUpper;
	IBOutlet UILabel *lblHeading;
	IBOutlet UILabel *lblDateDisplay;
	NSString *str_selectedDate;
}

//delegation
@property (nonatomic,retain) id <DatePickerViewControllerDelegate> delegate;

//@property (nonatomic,retain) UIView  *dateView;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,assign) BOOL isPickerVisible,isTimeView;
//@property (nonatomic,retain) IBOutlet UILabel *lblBgUpper;

@property (nonatomic,retain) IBOutlet UILabel *lblHeading;
@property (nonatomic,retain) IBOutlet UILabel *lblDateDisplay;
@property (nonatomic,retain) NSString *str_selectedDate;


-(id)initWithTodayAsMinimumDate;

-(id)initWith:(NSString *)selectedValue;

-(IBAction)doneBtnClicked:(id)sender;
-(IBAction)cancelBtnClicked:(id)sender;
@end
