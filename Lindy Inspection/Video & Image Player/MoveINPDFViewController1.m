//
//  ViewController.m
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import "MoveINPDFViewController1.h"

@interface MoveINPDFViewController1 ()<UIDocumentInteractionControllerDelegate>

@end

@implementation MoveINPDFViewController1
@synthesize PDFURL;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self startLoading];

    
        [Web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.PDFURL]]];
        
        Web_view.scalesPageToFit = YES;
        Web_view.contentMode = UIViewContentModeScaleAspectFit;

    
    

    
        
    
    
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
    
}
-(IBAction)dismissVIdeo:(id)sender{
    
    [self dismissViewControllerAnimated:self completion:nil];
}
-(IBAction)ShareVIdeo:(id)sender{
    // grab an item we want to share
    NSString *theMessage = self.Message;
//    NSArray *items = @[theMessage,self.PDFURL];
//    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
//    [self presentActivityController:controller];
    
    
    NSMutableArray *itemsToShare = [[NSMutableArray alloc] init];
    [itemsToShare addObject:theMessage];
    [itemsToShare addObject:self.PDFURLPath];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
    
    
//    UIDocumentInteractionController *documentInteractionController =[UIDocumentInteractionController interactionControllerWithURL:self.PDFURLPath];
//    documentInteractionController.name = theMessage;
//    documentInteractionController.delegate = self;
//    [documentInteractionController presentPreviewAnimated:YES];
//    
}
//- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
//    return self;
//}
-(BOOL)shouldAutorotate{
    
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            //  [self showToastForText:@"Send successfully..."];
            
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}
@end
