//
//  LoginManager.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 12/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

@import VzaarSwift;
#import <MobileCoreServices/MobileCoreServices.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Lindy_Inspection-Swift.h"
//#import "Vzaar.h"
@interface VzaarManager : NSObject<VzaarVideoClassProgressDelegate>
{
    
    MBProgressHUD *hudUploadProgress;
   // id <VZVideoUploader> uploader;

}


@property (nonatomic, retain, readwrite) Vzaar *vzaarApi;
+ (instancetype)sharedInstance;
-(void)setupVzaar;
- (float)VideoDurationFromURL:(NSURL *)videoURL;
- (float)VideoSizeFromURL:(NSURL *)videoUrl;
-(void)beginUpload:(NSString *)_title withCompletion:(void (^)(NSString *result))block;
@end
