//
//  ViewController.m
//  Lindy Inspection
//
//  Created by S S D on 24/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *Logout_Clicked;
- (IBAction)Logout_me:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Logout_me:(id)sender {
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userID"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    UIStoryboard *storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *landingVc;
    
    landingVc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController setViewControllers:@[landingVc] animated:NO];

}
@end
