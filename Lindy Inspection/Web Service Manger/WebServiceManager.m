//
//  VideosManager.m
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 18/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "WebServiceManager.h"
@implementation WebServiceManager

+ (instancetype)sharedInstance {
    static WebServiceManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WebServiceManager alloc] init];
    });
    return _sharedInstance;
}



- (void)SubmitLoginRequest:(LoginRequest *)addLogRequest
                   success:(successBlock)success
                   failure:(failureBlock)failure{
    
    addLogRequest.action = @"checkLogin";
    WebRequestHelper *webHelper = [WebRequestHelper sharedInstance];
    [webHelper hitRequestServiceFor:addLogRequest success:^(NSDictionary *result) {
        
        
        User *response = [[User alloc]initWithDictionary:[result valueForKey:@"result"] error:nil];

       success(response);
        
        
        //        MoveInMoveOutBaseResponse *response = [[MoveInMoveOutBaseResponse alloc]initWithDictionary:result error:nil];
        //        success(response);
        
    } failure:^(CustomError *error) {
        failure(error);
    }];
    
    
    
}
- (void)GetPropertyListWithSuccess:(successBlock)success
                           failure:(failureBlock)failure {
    
    BaseRequest *getOpponentListRequest = [[BaseRequest alloc]init];
    
    getOpponentListRequest.action = @"getProperty";
    
    WebRequestHelper *webHelper = [WebRequestHelper sharedInstance];
    [webHelper hitRequestServiceFor:getOpponentListRequest success:^(NSDictionary *result) {
        
        GetPropertyListResponse *response = [[GetPropertyListResponse alloc]initWithDictionary:result error:nil];
        success(response);
        
    } failure:^(CustomError *error) {
        failure(error);
    }];
    
}
- (void)SubmitIncidentReportRequest:(SubmitIncidentReportRequest *)addLogRequest
                            success:(successBlock)success
                            failure:(failureBlock)failure{
    
    
    addLogRequest.action = @"addRecord";
    WebRequestHelper *webHelper = [WebRequestHelper sharedInstance];
    [webHelper hitRequestServiceFor:addLogRequest success:^(NSDictionary *result) {
        
        
                BaseResponse *response = [[BaseResponse alloc]initWithDictionary:result error:nil];
                success(response);
        
    } failure:^(CustomError *error) {
        failure(error);
    }];

    
    
}
- (void)GetAllCompletedReportWithSuccess:(successBlock)success
                                failure:(failureBlock)failure {
    
    BaseRequest *getOpponentListRequest = [[BaseRequest alloc]init];
    
    getOpponentListRequest.action = @"getIncidentReports";
    
    WebRequestHelper *webHelper = [WebRequestHelper sharedInstance];
    [webHelper hitRequestServiceFor:getOpponentListRequest success:^(NSDictionary *result) {
        
        CompleteReportListResponse *response = [[CompleteReportListResponse alloc]initWithDictionary:result error:nil];
        success(response);
        
    } failure:^(CustomError *error) {
        failure(error);
    }];
    
}




@end
