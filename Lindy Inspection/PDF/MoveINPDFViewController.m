//
//  ViewController.m
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import "MoveINPDFViewController.h"

@interface MoveINPDFViewController ()

@end

@implementation MoveINPDFViewController
@synthesize PDFURL;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.PDFURL = [NSString stringWithFormat:@"%@",self.PDFURL];

    
    
//    NSURL *targetURL = [NSURL URLWithString:self.PDFURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
//    [Web_view loadRequest:request];
    
  WebRequestHelper *webHelper = [WebRequestHelper sharedInstance];

    [webHelper downloadVideoFromURL:self.PDFURL withProgress:nil completion:^(NSURL *filepath){
        
        [Web_view loadRequest:[NSURLRequest requestWithURL:filepath]];
        
        
        
    } onError:^(NSError *error){
        
//        [Client showNotificationOverNavigatonBarWithTitle:nil subtitle:@"Erro Occured try again..." type:TSMessageNotificationTypeSuccess duration:2.0];
        
        
    }];
    

    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self stopLoading];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self stopLoading];

}




- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self startLoading];
}
@end
