//
//  ViewController.h
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LoginViewController : BaseViewController

- (IBAction)Submit_Click:(id)sender;
- (IBAction)Remember_Click:(id)sender;

@property(nonatomic,retain)NSString *moveInOutType;


@property(nonatomic,weak)IBOutlet UITextField *txtUserNmae;
@property(nonatomic,weak)IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIImageView *ImgCheck;




@property(nonatomic,weak)IBOutlet UIButton *BtnSubmit;


@end

