//
//  IncidintReportScreen1ViewController.m
//  Lindy Inspection
//
//  Created by S S D on 25/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import "IncidintReportScreen3ViewController.h"
#import "VzaarManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@import AVFoundation;

#define PENDING_UPLOAD_KEY @"pendingUploadKey"

@interface IncidintReportScreen3ViewController ()
{

}
@end

@implementation IncidintReportScreen3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [[VzaarManager sharedInstance]setupVzaar];
        
    });

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ShowOptions{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped do nothing.
        [actionSheet dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // take photo button tapped.
        [self takeVideo];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // choose photo button tapped.
        [self choosePhoto];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self RemoveImages];
        
    }]];
    
    
    actionSheet.popoverPresentationController.sourceView = self.view;
    actionSheet.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
    
    [actionSheet showViewController:self sender:actionSheet];
    
    [self presentViewController:actionSheet animated:YES completion:^{
        
    }];
    
    
}
-(void)ShowOptions1{
    
    NSLog(@"ShowOptions1 Tapped");

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped do nothing.
        [actionSheet dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // take photo button tapped.
        [self takeVideo];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // choose photo button tapped.
        [self choosePhoto];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self RemoveVideo];
        
    }]];
    
    
    actionSheet.popoverPresentationController.sourceView = self.view;
    actionSheet.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
    
    [actionSheet showViewController:self sender:actionSheet];
    
    [self presentViewController:actionSheet animated:YES completion:^{
        
    }];
    
    
}
-(void)RemoveVideo{
    
    app.addRequest.videoName= @"";
    [self.BtnVideo setImage:[UIImage imageNamed:@"add-video"] forState:UIControlStateNormal];

}
-(void)RemoveImages{
    
    if([self.ControlFlag isEqualToString:@"SelectImage1"]){
        
        app.addRequest.imageName1= @"";
        [self.Btnimage1 setImage:[UIImage imageNamed:@"add-image"] forState:UIControlStateNormal];
        
    }
    else if([self.ControlFlag isEqualToString:@"SelectImage2"]){
        
        app.addRequest.imageName2= @"";
        [self.Btnimage2 setImage:[UIImage imageNamed:@"add-image"] forState:UIControlStateNormal];
        
        
    }
    else if([self.ControlFlag isEqualToString:@"SelectImage3"]){
        
        app.addRequest.imageName3= @"";
        [self.Btnimage3 setImage:[UIImage imageNamed:@"add-image"] forState:UIControlStateNormal];
        
        
    }
}
-(void)takeVideo{
    
    
    if([self.ControlFlag isEqualToString:@"SelectVideo"]){
        
        
        UIImagePickerController *libraryPicker = [[UIImagePickerController alloc] init];
        [libraryPicker setDelegate:self];
        [libraryPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [libraryPicker setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeMovie]];
        
        [self.parentViewController presentViewController:libraryPicker animated:YES completion:^{
            
        }];

    }
    else{
       
        UIImagePickerController *libraryPicker = [[UIImagePickerController alloc] init];
        [libraryPicker setDelegate:self];
        [libraryPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.parentViewController presentViewController:libraryPicker animated:YES completion:^{
                
            }];
        }];
        
    }
    
    
    
    
    
    
    
    
    
}

-(void)choosePhoto{
    
    
    if([self.ControlFlag isEqualToString:@"SelectVideo"]){
        
        UIImagePickerController *libraryPicker = [[UIImagePickerController alloc] init];
        [libraryPicker setDelegate:self];
        [libraryPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [libraryPicker setMediaTypes:[NSArray arrayWithObject:(NSString *)kUTTypeMovie]];
        
        [self.parentViewController presentViewController:libraryPicker animated:YES completion:^{
            
        }];
    }
    else{
    UIImagePickerController *libraryPicker = [[UIImagePickerController alloc] init];
    [libraryPicker setDelegate:self];
    [libraryPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [self presentViewController:libraryPicker animated:YES completion:^{
            
        }];    }];
    
    
    }
    
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img) img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    if(!(img.imageOrientation == UIImageOrientationUp ||
         img.imageOrientation == UIImageOrientationUpMirrored))
    {
        CGSize imgsize = img.size;
        UIGraphicsBeginImageContext(imgsize);
        [img drawInRect:CGRectMake(0.0, 0.0, imgsize.width, imgsize.height)];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
    if([self.ControlFlag isEqualToString:@"SelectImage1"]){
        
        app.addRequest.imageName1= [self encodeToBase64String:img];
        [self.Btnimage1 setImage:img forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:picker completion:^{
            
        }];
        
    }
    else if([self.ControlFlag isEqualToString:@"SelectImage2"]){
        
        app.addRequest.imageName2= [self encodeToBase64String:img];
        [self.Btnimage2 setImage:img forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:picker completion:^{
            
        }];

        
    }
    else if([self.ControlFlag isEqualToString:@"SelectImage3"]){
        
        app.addRequest.imageName3= [self encodeToBase64String:img];
        [self.Btnimage3 setImage:img forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:picker completion:^{
            
        }];

        
    }
    else {
        
        NSString *path = [[info valueForKey:UIImagePickerControllerMediaURL] path];
        [[NSUserDefaults standardUserDefaults] setValue:path forKey:PENDING_UPLOAD_KEY];
        
        [self dismissViewControllerAnimated:picker completion:^{
            
            
            
            [self.BtnVideo setImage:[self thumbnailFromVideoAtURL:[info valueForKey:UIImagePickerControllerMediaURL]] forState:UIControlStateNormal];

            
            
            // [self sendCloudinaryIDToServer];
            
        }];

    }
    
    
   
    
    
    //    [[picker presentingViewController] dismissModalViewControllerAnimated:YES];
}
- (NSString *)encodeToBase64String:(UIImage *)image {
    
    
    image = [UIImage compressImage:image
                     compressRatio:0.9f];
    
    return [UIImageJPEGRepresentation(image,1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (IBAction)GoNext:(id)sender{
    
   
    NSString *filepath = [[NSUserDefaults standardUserDefaults] valueForKey:PENDING_UPLOAD_KEY];
    
    if(filepath){
        
        [self beginUpload];
        
    }
    else
    {
        [self UploadData];
        
    }

    
    
}
-(void)UploadData{
    
    [self startLoading];
    
    app.addRequest.userID=[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"];
    
    [[WebServiceManager sharedInstance]SubmitIncidentReportRequest:app.addRequest success:^(BaseResponse *result) {
        [self stopLoading];
        
        
        
        if([result.success isEqualToString:@"1"]){
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self showToastForText:@"Report Saved"];
        }
        else{
            
            [self showToastForText:@"Something went wrong,Please try again"];
            
        }
        
        
        
    } failure:^(CustomError *error) {
        [self stopLoading];
        
        //        [self showToastForText:@"Could not save data at the moment"];
        [self showToastForText:@"Oops Error Occured !"];
        
    }];

    
}
- (IBAction)SelectImage1:(id)sender{
    
    
    self.ControlFlag=@"SelectImage1";
//    [self ShowOptions];
    [self performSelector:@selector(ShowOptions) withObject:nil afterDelay:0.001];

}
- (IBAction)SelectImage2:(id)sender{
    
    self.ControlFlag=@"SelectImage2";

   // [self ShowOptions];
    [self performSelector:@selector(ShowOptions) withObject:nil afterDelay:0.001];


}
- (IBAction)SelectImage3:(id)sender{
    
    
    self.ControlFlag=@"SelectImage3";

    //[self ShowOptions];
    [self performSelector:@selector(ShowOptions) withObject:nil afterDelay:0.001];


}
- (IBAction)SelectVideo:(id)sender{
    
    NSLog(@"SelectVideo Tapped");
    self.ControlFlag=@"SelectVideo";

   // [self ShowOptions1];
    [self performSelector:@selector(ShowOptions1) withObject:nil afterDelay:0.001];

    
}
-(void)beginUpload {
    
    NSString *filepath = [[NSUserDefaults standardUserDefaults] valueForKey:PENDING_UPLOAD_KEY];
    NSURL *vdoURL = [NSURL URLWithString:filepath];
    
    if([[VzaarManager sharedInstance]VideoDurationFromURL:vdoURL]<=15.00){
        
        [[VzaarManager sharedInstance]beginUpload:@"Test" withCompletion:^(NSString *result){
            
            
            if([result isEqualToString:@"error"]){
                
                [self showToastForText:@"Could not upload video at the moment"];
                
            }
            else
            {
                app.addRequest.videoName=result;
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:PENDING_UPLOAD_KEY];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self UploadData];
                
                
                
            }
            
            
        }];
        
        
        
        
    }
    else{
        
        [self showToastForText:@"Select video less than 15 seconds"];
        
    }
    
    
}
- (UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL {
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    
    return theImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
