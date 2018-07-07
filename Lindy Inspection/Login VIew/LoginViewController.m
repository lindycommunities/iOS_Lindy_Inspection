//
//  ViewController.m
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
BOOL isremember;
}
@end

@implementation LoginViewController
@synthesize moveInOutType;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view, typically from a nib.
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] != nil) {
        
        
        
        UIStoryboard *storyboardMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *landingVc;
        
            landingVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                self.navigationController.navigationBarHidden = YES;
        
        [self.navigationController setViewControllers:@[landingVc] animated:NO];
        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    isremember=NO;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Username"] != nil) {
        
        self.txtUserNmae.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Username"];
        self.txtPassword.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Password"];
        isremember=YES;
        self.ImgCheck.image=[UIImage imageNamed:@"check-box-active.png"];
        
    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"MoveIN"]){
    }

    
}

- (IBAction)Remember_Click:(id)sender
{
    if(isremember){
        
        self.ImgCheck.image=[UIImage imageNamed:@"check-box-disable.png"];
        isremember=NO;
        
        
        
    }
    else
    {
        self.ImgCheck.image=[UIImage imageNamed:@"check-box-active.png"];
        isremember=YES;
        
        
        
        
        
    }

    
}




- (IBAction)Submit_Click:(id)sender {
    [self startLoading];

    if(self.txtUserNmae.text.length){
        
         if(self.txtPassword.text.length){
             
             
             LoginRequest *request = [[LoginRequest alloc]init];
             request.username=self.txtUserNmae.text;
             request.password=self.txtPassword.text;

             [[WebServiceManager sharedInstance]SubmitLoginRequest:request success:^(BaseResponse *result) {
                 [self stopLoading];
                 
                 
                 
                 User *resp = (User*)result;
                 
                 if(isremember){
                     
                     [[NSUserDefaults standardUserDefaults] setValue:self.txtPassword.text forKey:@"Password"];
                     [[NSUserDefaults standardUserDefaults] setValue:self.txtUserNmae.text forKey:@"Username"];
                     
                 }
                 else{
                     
                     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Password"];
                     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Username"];

                 }
                 
                 
                 [[NSUserDefaults standardUserDefaults] setValue:resp.userID forKey:@"userID"];
                 [[NSUserDefaults standardUserDefaults] setValue:resp.roleAID forKey:@"roleAID"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 //[self performSegueWithIdentifier:@"HomePage" sender:nil];
                 
                 
                 
                 UIViewController *landingVc;
                 
                     landingVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                 
                 self.navigationController.navigationBarHidden = YES;
                 [self.navigationController setViewControllers:@[landingVc] animated:NO];
                     
                                   
                 
                 
             } failure:^(CustomError *error) {
                 [self stopLoading];
                 
                 //        [self showToastForText:@"Could not save data at the moment"];
                 [self showToastForText:@"Oops Error Occured !"];
                 
             }];

        
         }
         else{
             
             [self ShowMesage:@"Please enter Password"];

         }
    }
    
    else
    {
        

        [self ShowMesage:@"Please enter username"];
        
    }
    
}
-(void)ShowMesage:(NSString *)_message{
    
    [self showToastForText:_message];

}
@end
