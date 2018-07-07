//
//  IncidintReportScreen1ViewController.m
//  Lindy Inspection
//
//  Created by S S D on 25/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import "IncidintReportScreen2ViewController.h"

@interface IncidintReportScreen2ViewController ()

@end

@implementation IncidintReportScreen2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)GoNext:(id)sender{

    
    app.addRequest.correctiveAction= self.TxtCorrectiveAction.text;
    app.addRequest.actionToAvoidFutureIncident= self.TxtFutureAction.text;
    app.addRequest.witnessesNamePhone= self.TxtWitnessNamePhone.text;


    UIViewController *loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IncidintReportScreen3ViewController"]; //or the homeController
    [self.navigationController pushViewController:loginController animated:YES];
}

@end
