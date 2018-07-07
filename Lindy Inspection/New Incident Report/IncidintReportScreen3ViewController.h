//
//  IncidintReportScreen1ViewController.h
//  Lindy Inspection
//
//  Created by S S D on 25/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIImage+ImageCompress.h"
#import "AppDelegate.h"

@interface IncidintReportScreen3ViewController : BaseViewController
{
    AppDelegate *app;

}
@property (strong, nonatomic) IBOutlet UIButton *Btnimage1;
@property (strong, nonatomic) IBOutlet UIButton *Btnimage2;
@property (strong, nonatomic) IBOutlet UIButton *Btnimage3;
@property (strong, nonatomic) IBOutlet UIButton *BtnVideo;


- (IBAction)GoNext:(id)sender;
- (IBAction)SelectImage1:(id)sender;
- (IBAction)SelectImage2:(id)sender;
- (IBAction)SelectImage3:(id)sender;
- (IBAction)SelectVideo:(id)sender;
@property(nonatomic,retain)NSString *ControlFlag;

@end
