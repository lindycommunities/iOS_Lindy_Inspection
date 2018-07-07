//
//  BaseResponse.h
//  AxisWallet
//
//  Created by Bonnie Jaiswal on 02/08/12.
//  Copyright (c) 2012 Bonnie Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseResponse : BaseModel


@property (nonatomic) NSString *success;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *errorCode;
@property (nonatomic) NSString *errorDescription;
@property (nonatomic) NSDictionary *data;
@property (nonatomic) NSString *pdfPath;

@end
