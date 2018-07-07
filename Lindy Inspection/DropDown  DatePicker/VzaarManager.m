//
//  LoginManager.m
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 12/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "VzaarManager.h"
#define PENDING_UPLOAD_KEY @"pendingUploadKey"
#import <AVFoundation/AVFoundation.h>

@implementation VzaarManager

+ (instancetype)sharedInstance {
    static VzaarManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[VzaarManager alloc] init];
    });
    return _sharedInstance;
}
-(void)setupVzaar{
    
//    self.vzaarApi = [[Vzaar alloc] initWithURL:[NSURL URLWithString:kLiveAPIEndPoint]];
////    [self.vzaarApi setOAuthSecret:@"helin0202"];
////    [self.vzaarApi setOAuthToken:@"HNe2c4rTCPUslPDTqcCrYby6897hL2fKDMoORAsMzOc"];
//    
//    [self.vzaarApi setOAuthSecret:@"embed-iowa-bang"];
//    [self.vzaarApi setOAuthToken:@"DTqjqY9dpCNvN4iyKJCk"];
//    [Vzaar sharedInstance].config = [[VzaarConfig alloc]initWithClientId:@"embed-iowa-bang" authToken:@"DTqjqY9dpCNvN4iyKJCk"];
    [Vzaar sharedInstance].config = [[VzaarConfig alloc]initWithClientId:@"arlen-juice-cowl" authToken:@"f8KQd6PT-J2nLxTNQLHs"];
    
    
    
    
    
}


-(void)vzaarVideoUploadProgressWithProgress:(double)progress{
    CGFloat someProgress = (CGFloat)progress;
    NSLog(@"progress: %f",someProgress);
    hudUploadProgress.progress = progress;
    
    
    
}

-(void)beginUpload:(NSString *)_title withCompletion:(void (^)(NSString *result))block{
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    UIViewController *currentVc = [(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController topViewController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        hudUploadProgress = [MBProgressHUD showHUDAddedTo:currentVc.view animated:YES];
        hudUploadProgress.mode = MBProgressHUDModeAnnularDeterminate;
        hudUploadProgress.labelText = @"Uploading";
        
    });

    
    
    NSString *filepath = [[NSUserDefaults standardUserDefaults] valueForKey:PENDING_UPLOAD_KEY];
    NSURL *vdoURL = [NSURL URLWithString:filepath];

    VzaarVideoClass *ss=[[VzaarVideoClass alloc]init];
    ss.delegate=self;
    [ss uploadVideoWithName:_title fileURLWithPath:vdoURL success:^(VzaarVideo * vid) {
        
        [hudUploadProgress hide:YES];
        
       // NSLog(@"didUploadVideo: %@ : videoID:%ld",vid.url,(unsigned long)[vid valueForKey:@"id"]);
        NSLog(@"didUploadVideo: %@ : ",vid.seo_url);
        NSLog(@"didUploadVideo: %@ : ",vid.thumbnail_url);
        NSLog(@"didUploadVideo: %@ : ",[vid description]);
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

        NSArray *arr =[vid.thumbnail_url componentsSeparatedByString:@"/"];
        
        for(NSString *ss in arr){
            
            NSLog(@"ss: %@ : ",ss);
            
        }
        block([arr objectAtIndex:3]);
        


        
        
        
    } failure:^(VzaarError * error) {
        
        [hudUploadProgress hide:YES];
       // NSLog(@"didFailToUploadVideo: %@ : error:%@",videoPath,error.localizedDescription);
        block(@"Error");

        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        
       // [self presentError:[error description]];

        
        
    } noResponse:^(NSError * error) {
        
        [hudUploadProgress hide:YES];
      //  NSLog(@"didFailToUploadVideo: %@ : error:%@",videoPath,error.localizedDescription);
        
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        
       // [self presentError:error];

        
    }];

    
      //  NSURL *vdoURL = [NSURL URLWithString:filepath];

    
//    VzaarCreateLinkUploadParameters *lnk = [[VzaarCreateLinkUploadParameters alloc]initWithUrl:filepath];
//    lnk.title=_title;
   // [[Vzaar sharedInstance]upload]
     
     
     
     
//     createLinkUploadWithVzaarCreateLinkUploadParameters:lnk success:^(VzaarVideo *video){
//         
//         
//         NSLog(@"1 %@",[video description]);
//         
//         
//     } failure:^(VzaarError *rrr){
//         
//         NSLog(@"2 %@",[rrr description]);
//         
//         
//     } noResponse:^(NSError *res){
//         
//         NSLog(@"3 %@",[res description]);
//         
//     }];

     
     }
/*-(void)beginUpload:(NSString *)_title{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        id <VZVideoUploader> videoUploader = [self.vzaarApi
                                              beginUploadOfVideoWithTitle:_title
                                              description:@"Test Video"
                                              profile:2
                                              filePath:[[NSUserDefaults standardUserDefaults] valueForKey:PENDING_UPLOAD_KEY]
                                              replacingVideoWithId:0
                                              delegate:self];
        
        if (videoUploader) {
            
            
            [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            UIViewController *currentVc = [(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController topViewController];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                hudUploadProgress = [MBProgressHUD showHUDAddedTo:currentVc.view animated:YES];
                hudUploadProgress.mode = MBProgressHUDModeAnnularDeterminate;
                hudUploadProgress.labelText = @"Uploading";
                
            });
            
            uploader = videoUploader;
        } else {
            
            
            [self presentError:[NSError errorWithDomain:@"com.vzaar.Vzaar"
                                                   code:0
                                               userInfo:[NSDictionary dictionaryWithObject:@"Couldn't create upload"
                                                                                    forKey:NSLocalizedDescriptionKey]]];
        }
        
    });
}
*/

/*-(void)uploader:(id <VZVideoUploader>)anUploader didUploadDataWithProgress:(double)progress {
    
    CGFloat someProgress = (CGFloat)progress;
    NSLog(@"progress: %f",someProgress);
    hudUploadProgress.progress = progress;
    
    
}

-(void)uploader:(id <VZVideoUploader>)anUploader didFailToUploadVideo:(NSString *)videoPath withError:(NSError *)error {
    
    [hudUploadProgress hide:YES];
    NSLog(@"didFailToUploadVideo: %@ : error:%@",videoPath,error.localizedDescription);
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self presentError:error];
    
    uploader = nil;
}

-(void)uploader:(id <VZVideoUploader>)anUploader didUploadVideo:(NSString *)videoPath withVideoId:(NSUInteger)videoId {
    
    [hudUploadProgress hide:YES];
    
    NSLog(@"didUploadVideo: %@ : videoID:%ld",videoPath,(unsigned long)videoId);
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    uploader = nil;
    
   // [self sendVzaarIDToServer:[NSString stringWithFormat:@"%d",videoId]];
    
}
- (void)presentError:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"The operation could not be completed."
                                                        message:[NSString stringWithFormat:@"%@", error]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}
*/
- (float)VideoDurationFromURL:(NSURL *)videoURL {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL: videoURL options:nil];
    CMTime duration = asset.duration;
    NSLog(@"%f",CMTimeGetSeconds(duration));
    return CMTimeGetSeconds(duration);
}
- (float)VideoSizeFromURL:(NSURL *)videoUrl {

NSError *attributesError;
NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[videoUrl path] error:&attributesError];
NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
long long fileSize = [fileSizeNumber longLongValue];
float sz= ((fileSize/1024)/1024);
    
    return sz;

}
@end
