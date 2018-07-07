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

@interface IncidintReportScreen2ViewController : BaseViewController{
    
    AppDelegate *app;

}
@property (strong, nonatomic) IBOutlet UITextView *TxtCorrectiveAction;
@property (strong, nonatomic) IBOutlet UITextView *TxtFutureAction;
@property (strong, nonatomic) IBOutlet UITextView *TxtWitnessNamePhone;

- (IBAction)GoNext:(id)sender;

@end
