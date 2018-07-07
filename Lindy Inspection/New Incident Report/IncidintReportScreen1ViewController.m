//
//  IncidintReportScreen1ViewController.m
//  Lindy Inspection
//
//  Created by S S D on 25/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import "IncidintReportScreen1ViewController.h"
//#import "WebServiceManager.h"
#import "SLSelectionViewController.h"
#import "DatePickerViewController.h"
#import "SubmitIncidentReportRequest.h"

@interface IncidintReportScreen1ViewController ()<SLSelectionDelegate,DatePickerViewControllerDelegate>

@end

@implementation IncidintReportScreen1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    app.addRequest = [[SubmitIncidentReportRequest alloc]init];

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

-(void)getAllProperty{
    
    [self startLoading];
    
    
    [[WebServiceManager sharedInstance]GetPropertyListWithSuccess:^(BaseResponse *result) {
        
        [self stopLoading];
        
        GetPropertyListResponse *response = (GetPropertyListResponse *)result;
        if (response.result.count) {
            self.arrProperty = [[NSArray alloc]initWithArray:response.result];
            [self showSelectionVCForOpponents];
        }
        else{
            
            [self showToastForText:@"No Property Found"];
            
        }
        
    } failure:^(CustomError *error) {
        [self stopLoading];
        
        [self showToastForText:@"Cannot fetch Property. Please try again"];
    }];
    
}
-(void)showSelectionVCForOpponents{
    
    
    
    
        
        SLSelectionViewController *aWSelectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SLSelectionViewController"];
        
        
        aWSelectionViewController.itemList = self.arrProperty;//arrLevels; //list to display
        aWSelectionViewController.displayItemKey = @"building"; //key of value to display
        //   aWSelectionViewController.subtitleDisplayItemKey =@"";// @"coachID"; //key of value to display
        aWSelectionViewController.delegate  = self;
        aWSelectionViewController.titleForSelection = @"Select Property";
        [self presentViewController:aWSelectionViewController animated:YES completion:nil];
    
    
    
    
    
    
}
-(void)didSelectItem:(BaseModel *)selectedItem{
    
    
        Property *opponent = (Property *)selectedItem;
        
        self.TxtProperty.text = opponent.building;
}

- (IBAction)ShowProperty:(id)sender{
    self.ControlFlag=@"ShowProperty";

    if(self.arrProperty.count){
        
        [self showSelectionVCForOpponents];
        
    }
    else
    {
        [self getAllProperty];
        
    }

}
- (IBAction)ShowDate:(id)sender{
    
    self.ControlFlag=@"ShowDate";
    DatePickerViewController *dpvc = [[DatePickerViewController alloc] init];
    [dpvc setDelegate:self];
    [dpvc setTitle:@"Select Date"];
    UINavigationController *navDpvc = [[UINavigationController alloc] initWithRootViewController:dpvc];
    [navDpvc.navigationBar setTintColor:[UIColor blackColor]];
    [navDpvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [navDpvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navDpvc animated:YES completion:nil];
    
    
}
#pragma mark will handle dismissal for datepicker

- (void)DatePickerViewControllerDidFinish:(DatePickerViewController *)controller
{
    //fetch datepicker value from controller object
    
    if([self.ControlFlag isEqualToString:@"ShowTime"]){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];	//Not shown
        [dateFormatter setDateFormat:@"h:mm a"];
        self.TIMEAMPM = [dateFormatter stringFromDate:[controller.datePicker date]];
        self.TxtIncidentTime.text = self.TIMEAMPM;
        [self dismissViewControllerAnimated:YES completion:nil];

        
    }
    else{
    NSDateFormatter  *dateofbirthformat = [[NSDateFormatter alloc] init];
    [dateofbirthformat setTimeStyle:NSDateFormatterNoStyle];
    [dateofbirthformat setDateFormat:@"MM-dd-yyyy"];
    self.TxtIncidentDate.text = [dateofbirthformat stringFromDate:[controller.datePicker date]];

    NSDateFormatter *dateofbirthformat1 = [[NSDateFormatter alloc] init];
    [dateofbirthformat1 setTimeStyle:NSDateFormatterNoStyle];
    [dateofbirthformat1 setDateFormat:@"yyyy-MM-dd"];
    self.DATEYYMMDD = [dateofbirthformat1 stringFromDate:[controller.datePicker date]];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    
}
#pragma mark will handel dismmiss of datepicker if user press cancel btn
- (void)DatePickerViewControllerDidCancel:(DatePickerViewController *)controller
{
    //do nothing just dissmiss datepicker modelview
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ShowTime:(id)sender{
    self.ControlFlag=@"ShowTime";

    DatePickerViewController *dpvc = [[DatePickerViewController alloc] init];
    [dpvc setDelegate:self];
    dpvc.isTimeView=YES;
    [dpvc setTitle:@"Select Time"];
    UINavigationController *navDpvc = [[UINavigationController alloc] initWithRootViewController:dpvc];
    [navDpvc.navigationBar setTintColor:[UIColor blackColor]];
    [navDpvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [navDpvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navDpvc animated:YES completion:nil];
}


- (IBAction)GoNext:(id)sender {
    
    
    if(self.TxtProperty.text.length){
        
        app.addRequest.propertyName= self.TxtProperty.text;
        app.addRequest.dateOfIncident= self.DATEYYMMDD;
        app.addRequest.timeOfIncident= self.TIMEAMPM;
        app.addRequest.locationOfIncident= self.TxtIncidentLocation.text;
        app.addRequest.descriptionOfIncident= self.TxtIncidentDescription.text;

    UIViewController *loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IncidintReportScreen2ViewController"]; //or the homeController
    [self.navigationController pushViewController:loginController animated:YES];
    }
    else{
        
        [self showToastForText:@"Please select the Property"];
    }

}
@end
