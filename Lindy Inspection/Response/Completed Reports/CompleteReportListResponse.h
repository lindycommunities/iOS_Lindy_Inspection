//
//  AWGetVideoMoveInMoveOutistResponse.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseResponse.h"
#import "CompleteReport.h"

@interface CompleteReportListResponse : BaseResponse

@property (nonatomic) NSArray <CompleteReport> *result;

@end
