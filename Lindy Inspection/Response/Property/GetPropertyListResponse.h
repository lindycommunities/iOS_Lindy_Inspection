//
//  AWGetVideoMoveInMoveOutistResponse.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseResponse.h"
#import "Property.h"

@interface GetPropertyListResponse : BaseResponse

@property (nonatomic) NSArray <Property> *result;

@end
