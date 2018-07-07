//
//  IncidintReportScreen1ViewController.h
//  Lindy Inspection
//
//  Created by S S D on 25/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppDelegate.h"

@interface IncidintReportScreen1ViewController : BaseViewController<UITextFieldDelegate>{
    
    AppDelegate *app;

}
@property (strong, nonatomic) IBOutlet UITextField *TxtProperty;
@property (strong, nonatomic) IBOutlet UITextField *TxtIncidentDate;
@property (strong, nonatomic) IBOutlet UITextField *TxtIncidentTime;
@property (strong, nonatomic) IBOutlet UITextView *TxtIncidentLocation;
@property (strong, nonatomic) IBOutlet UITextView *TxtIncidentDescription;
- (IBAction)GoNext:(id)sender;
- (IBAction)ShowProperty:(id)sender;
- (IBAction)ShowDate:(id)sender;
- (IBAction)ShowTime:(id)sender;

@property(nonatomic,retain)NSArray *arrProperty;
@property(nonatomic,retain)NSString *DATEYYMMDD;
@property(nonatomic,retain)NSString *TIMEAMPM;
@property(nonatomic,retain)NSString *ControlFlag;


@end
