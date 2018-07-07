//
//  BaseManager.h
//  SoapAfNetworkingTest
//
//  Created by Bonnie Jaiswal on 04/06/15.
//  Copyright (c) 2015 Bonnie Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomError.h"
#import "WebRequestHelper.h"
#import "BaseRequest.h"
#import "BaseResponse.h"

typedef void (^successBlock)(BaseResponse *result);
typedef void (^failureBlock)(CustomError *error);
typedef void (^successBlockWithDictionay)(NSDictionary *result);

typedef void (^successBlockWithBlock)(BaseResponse *result, void (^)());
typedef void (^failureBlockWithBlock)(CustomError *error, void (^)());

typedef void(^successBlockArray)(NSArray *resultArray);

@interface BaseManager : NSObject
- (CustomError *)createErrorFromResponse:(BaseResponse *)responseDictionary;
- (CustomError *)GetCustomErrorFromNSError:(NSError *)error;



@end
