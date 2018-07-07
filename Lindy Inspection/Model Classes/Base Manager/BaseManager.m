//
//  BaseManager.m
//  SoapAfNetworkingTest
//
//  Created by Bonnie Jaiswal on 04/06/15.
//  Copyright (c) 2015 Bonnie Jaiswal. All rights reserved.
//

#import "BaseManager.h"

@implementation BaseManager


- (CustomError *)createErrorFromResponse:(BaseResponse *)responseDictionary
{
    CustomError *error=[[CustomError alloc]init];
    NSString *errorCode = responseDictionary.errorCode;
    if ([errorCode isEqualToString:@"999"]) {
        error.isSuccess=true;
    } else {
        error.errorCode = responseDictionary.errorCode;
        error.isSuccess = false;
        if (!error.errorDescription.length) {
            error.errorDescription = @"ERROR";
        }
        error.errorDescription = responseDictionary.errorDescription;
    }
    return error;
}

- (NSString *)getResponseBody:(NSDictionary *)jsonDict
                    forAction:(NSString *)action {
    NSDictionary *envDict=jsonDict[@"s:Envelope"];
    NSDictionary *bodyDict=envDict[@"s:Body"];
    NSString *responseKey = [NSString stringWithFormat:@"%@Response",action];
    NSString *resultKey = [NSString stringWithFormat:@"%@Result",action];
    if ([[bodyDict allKeys] containsObject:responseKey]) {
        NSDictionary *responseDict = bodyDict[responseKey];
        if ([[responseDict allKeys] containsObject:resultKey]) {
            return responseDict[resultKey][@"text"];
        }
        return nil;
    }
    return nil;
}


- (NSDictionary *)getResponseBodyForNewRequest:(NSDictionary *)jsonDict
                                     forAction:(NSString *)action {
    NSDictionary *dict = jsonDict;
    if ([[dict allKeys] containsObject:@"soapenv:Envelope"]) {
        dict = [dict valueForKey:@"soapenv:Envelope"];
        if ([[dict allKeys] containsObject:@"soapenv:Body"]) {
            dict = [dict valueForKey:@"soapenv:Body"];
            NSString *responseKey = [NSString stringWithFormat:@"%@Response",action];
            if ([[dict allKeys] containsObject:responseKey]) {
                dict = [dict valueForKey:responseKey];
                NSString *returnKey = [NSString stringWithFormat:@"%@Return",action];
                if ([[dict allKeys] containsObject:returnKey]) {
                    dict = [dict valueForKey:returnKey];
                }
            }
        }
    }
    return dict;
}

- (CustomError *)GetCustomErrorFromNSError:(NSError *)error {
    CustomError *cerror=[[CustomError alloc]init];
    //TODO: code to extract human readable Error from NSError.
    cerror.isSuccess=false;
    cerror.errorCode = @"999";
    cerror.errorDescription=[NSString stringWithFormat:@"Server Error: %@",error.localizedDescription];
    return cerror;
}

- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}


@end
