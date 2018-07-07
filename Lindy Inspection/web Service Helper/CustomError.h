//
//  CustomError.h
//  SoapAfNetworkingTest
//
//  Created by Bonnie Jaiswal on 04/06/15.
//  Copyright (c) 2015 Bonnie Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomError : NSObject

@property (nonatomic, copy)NSString *errorCode;
@property (nonatomic)BOOL isSuccess;
@property (nonatomic, copy)NSString *errorDescription;
@property (nonatomic, strong)id returnObject;
@end
