//
//  VideosManager.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 18/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseManager.h"
#import "User.h"
#import "GetPropertyListResponse.h"
#import "CompleteReportListResponse.h"




#import "LoginRequest.h"
#import "SubmitIncidentReportRequest.h"

@interface WebServiceManager: BaseManager{
    
}
+ (instancetype)sharedInstance;


- (void)SubmitLoginRequest:(LoginRequest *)addLogRequest
                   success:(successBlock)success
                   failure:(failureBlock)failure;

- (void)GetPropertyListWithSuccess:(successBlock)success
                           failure:(failureBlock)failure;

- (void)SubmitIncidentReportRequest:(SubmitIncidentReportRequest *)addLogRequest
                   success:(successBlock)success
                   failure:(failureBlock)failure;
- (void)GetAllCompletedReportWithSuccess:(successBlock)success
                                 failure:(failureBlock)failure;

@end
