//
//  WebRequestHelper.m
//  AxisWallet
//
//  Created by Bonnie Jaiswal on 02/06/15.
//  Copyright (c) 2012 Bonnie Jaiswal. All rights reserved.
//

#import "WebRequestHelper.h"
#import <AFNetworking/AFNetworking.h>
//#import "MoveInMoveOutBaseResponse.h"
//#import "MoveInMoveOutBaseManager.h"
//#import <KSToastView/KSToastView.h>
#import  <CRToast/CRToast.h>

@interface WebRequestHelper(){
    NSMutableArray *certsArray;
    int countRetry;
}

@end

@implementation WebRequestHelper
@synthesize progress;

+ (instancetype)sharedInstance {
    static WebRequestHelper *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WebRequestHelper alloc] init];
    });
    return _sharedInstance;
}


- (void)hitRequestServiceFor:(BaseRequest *)request
                  success:(void (^) (NSDictionary *result))success
                  failure:(void (^) (CustomError *error))failure {
    


    if(![[AFNetworkReachabilityManager sharedManager]isReachable]){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            //@"http://www.whitelakeinteractive.com/level7tennis/api/level7api.php?xAction=member_login"
            //@"http://requestb.in/ucr5w1uc"
            
            //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            NSDictionary *parametersDict = [request dictionary];


            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            
            //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            
            [manager.requestSerializer setTimeoutInterval:180.0];
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",kBaseURL,request.action];

            NSLog(@"Request :- %@ \n %@",urlStr,parametersDict);

            [manager POST:urlStr parameters:parametersDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"Response :- %@",responseObject);
               // [[UIApplication sharedApplication] endIgnoringInteractionEvents];

                if ([responseObject[@"success"]boolValue]) {
                    
                    NSLog(@"success!");
                    success(responseObject);
                }
                else{
                    if([request.action isEqualToString:@"login"]){
                        
                        failure([self createCustomErrorFromText:responseObject[@"result"]]);

                        
                    }
                    else{
                    failure([self createCustomErrorFromText:responseObject[@"message"]]);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error: %@", error);
                
                
                NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                NSLog(@"%@",ErrorResponse);
                
                
               // [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                failure([self GetCustomErrorFromNSError:error]);
            }];
        });
    }
    else
    {
        //[[UIApplication sharedApplication] endIgnoringInteractionEvents];

        // showing error here, shows it many times, eg opening oneView will show 3-4 alerts, becase many requests in one screen.
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"@Lime" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
       // [KSToastView ks_showToast:@"Please check your internet connection" duration:2.0f];
        NSDictionary *options = @{
                                  kCRToastTextKey :@"Please check your internet connection",
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor],
                                  kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                  kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                  kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                                  kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight)
                                  };
        [CRToastManager showNotificationWithOptions:options
                                    completionBlock:^{
                                        NSLog(@"Completed");
                                    }];
        
        failure([self createNoInternetError]);
    }

}

- (CustomError *)GetCustomErrorFromNSError:(NSError *)error {
    CustomError *cerror = [[CustomError alloc]init];
    //TODO: code to extract human readable Error from NSError.
    cerror.isSuccess = false;
    NSString *errorDesc = @"";
    switch (error.code) {
        case 500:
            errorDesc = @"xxxx";
            break;
            
        default:
            errorDesc = [NSString stringWithFormat:@"%@",error.localizedDescription];
            break;
    }
    cerror.errorCode = @"999";
    cerror.errorDescription = errorDesc;
    return cerror;
}

- (CustomError *)createNoInternetError {
    CustomError *cerror=[[CustomError alloc]init];
    //TODO: code to extract human readable Error from NSError.
    cerror.isSuccess=false;
    cerror.errorCode = @"998";
    cerror.errorDescription=[NSString stringWithFormat:@"Please check your internet connection"];
    return cerror;
}

- (CustomError *)createCustomErrorFromText:(NSString *)errorText {
    CustomError *cerror=[[CustomError alloc]init];
    //TODO: code to extract human readable Error from NSError.
    cerror.isSuccess=false;
    cerror.errorCode = @"100";
    cerror.errorDescription=[NSString stringWithFormat:@"%@",errorText];
    return cerror;
}
- (void) downloadVideoFromURL: (NSString *) URL withProgress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(NSURL *filePath))completionBlock onError:(void (^)(NSError *error))errorBlock
{
    
    hudUploadProgress = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication]keyWindow] animated:YES];
    hudUploadProgress.mode = MBProgressHUDModeAnnularDeterminate;
    hudUploadProgress.labelText = @"Loading Please Wait...";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *formattedURL = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:formattedURL];
    /*
    
    //Configuring the session manager
    
    //Most URLs I come across are in string format so to convert them into an NSURL and then instantiate the actual request
    
    
    
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress)
                                              {
                                                  NSLog(@"Progress: %f", downloadProgress.fractionCompleted);
                                                  hudUploadProgress.progress =downloadProgress.fractionCompleted;
                                                  
                                                  
                                              } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
                                              {
                                                  
                                                  NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                  
                                                  
                                                  NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Test.pdf"];
                                                  
                                                  //If we already have a video file saved, remove it from the phone
                                                  [self removeVideoAtPath:fullURL];
                                                  return fullURL;
                                                  
                                                  
                                              } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
                                              {
                                                  //        if (response && successBlock) {
                                                  //            successBlock(response,filePath);
                                                  //        }
                                                  if (!error) {
                                                      //If there's no error, return the completion block
                                                      [hudUploadProgress hide:YES];
                                                      
                                                      completionBlock(filePath);
                                                  } else {
                                                      //Otherwise return the error block
                                                      [hudUploadProgress hide:YES];
                                                      
                                                      errorBlock(error);
                                                  }
                                                  
                                              }];
    
    [downloadTask resume];
    
    
    */
    
    NSURLSessionDownloadTask *downloadTask1 = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"Progress: %f", downloadProgress.fractionCompleted);
        NSLog(@"Progress: %f", downloadProgress.fractionCompleted);
       // dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
            hudUploadProgress.progress =downloadProgress.fractionCompleted;
            
       // });

        
        

    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        
        //NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Test.pdf"];
        
        NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",self.File_Name]];

        
        //If we already have a video file saved, remove it from the phone
        [self removeVideoAtPath:fullURL];
        return fullURL;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        if (!error) {
            //If there's no error, return the completion block
            [hudUploadProgress hide:YES];
            
            completionBlock(filePath);
        } else {
            //Otherwise return the error block
            [hudUploadProgress hide:YES];
            
            errorBlock(error);
        }

        
    }];
    
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"setDownloadTaskDidWriteDataBlock: %lld %lld %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
       // hudUploadProgress.progress = totalBytesWritten/totalBytesExpectedToWrite;
//        CGFloat written = totalBytesWritten/100;
//        CGFloat total = totalBytesExpectedToWrite/100;
//        CGFloat percentageCompleted = written/total;
//        hudUploadProgress.progress=percentageCompleted/100;
        if (!self.progress) {
            self.progress = [NSProgress progressWithTotalUnitCount:totalBytesExpectedToWrite];
            self.progress.kind = NSProgressKindFile;
        }
        
        self.progress.completedUnitCount = totalBytesWritten;
        hudUploadProgress.progress=self.progress.fractionCompleted;
        
        
        //Return the completed progress so we can display it somewhere else in app
        //progressBlock(percentageCompleted);
        

    }];
    
    [downloadTask1 resume];
    
    
    
    
   /* NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
            [hudUploadProgress setProgress:downloadProgress.fractionCompleted];
            
        });
        
        
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        
        NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Test.pdf"];
        
        //If we already have a video file saved, remove it from the phone
        [self removeVideoAtPath:fullURL];
        return fullURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        // Do operation after download is complete
        
        if (!error) {
            //If there's no error, return the completion block
            [hudUploadProgress hide:YES];
            
            completionBlock(filePath);
        } else {
            //Otherwise return the error block
            [hudUploadProgress hide:YES];
            
            errorBlock(error);
        }
        
    }];
    [downloadTask resume];

    */
    
    
    
}


- (void)removeVideoAtPath:(NSURL *)filePath
{
    NSString *stringPath = filePath.path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:stringPath]) {
        [fileManager removeItemAtPath:stringPath error:NULL];
    }
    [self RemoveAll];
}

-(void)RemoveAll{
    
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error = nil;
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
    }
    
  
}


- (NSURL *)FilePath
{
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//    NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Test.pdf"];

    NSURL *fullURL = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",self.File_Name]];

    
    
    return fullURL;
    
}
- (BOOL)FileExist:(NSURL *)filePath
{
    NSString *stringPath = filePath.path;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:stringPath]) {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
