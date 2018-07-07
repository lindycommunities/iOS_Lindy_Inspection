//
//  WebRequestHelper.h
//  AxisWallet
//
//  Created by Bonnie Jaiswal on 02/06/15.
//  Copyright (c) 2012 Bonnie Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "ServiceResponse.h"
#import "CustomError.h"
#import "BaseRequest.h"
#import "MBProgressHud.h"



//#define kBaseURL @"http://www.whitelakedigital.com/mitchel-products/mitchel_products_api"

#define kBaseURL @"http://certification.comehometolindy.com/certificate-production_api/api/incident-report-api.php?action="


@interface WebRequestHelper : NSObject{
    
    MBProgressHUD *hudUploadProgress;

}
@property(nonatomic,retain)    NSProgress *progress;
@property(nonatomic,retain)    NSString *File_Name;

+ (instancetype)sharedInstance;

- (void)hitRequestServiceFor:(BaseRequest *)soapRequest
                     success:(void (^) (NSDictionary *result))success
                     failure:(void (^) (CustomError *error))failure;

- (void)requestServiceFor:(BaseRequest *)soapRequest
                  success:(void (^) (NSDictionary *result))success
                  failure:(void (^) (CustomError *error))failure;
- (void) downloadVideoFromURL: (NSString *) URL withProgress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(NSURL *filePath))completionBlock onError:(void (^)(NSError *error))errorBlock;


@end
