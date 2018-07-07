//
//  AddVideoRequest.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 18/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseRequest.h"

@interface SubmitIncidentReportRequest : BaseRequest
@property (nonatomic,strong) NSString *dateOfIncident;
@property (nonatomic,strong) NSString *propertyName;
@property (nonatomic,strong) NSString *timeOfIncident;
@property (nonatomic,strong) NSString *locationOfIncident;
@property (nonatomic,strong) NSString *descriptionOfIncident;
@property (nonatomic,strong) NSString *correctiveAction;
@property (nonatomic,strong) NSString *actionToAvoidFutureIncident;
@property (nonatomic,strong) NSString *witnessesNamePhone;
@property (nonatomic,strong) NSString *imageName1;
@property (nonatomic,strong) NSString *imageName2;
@property (nonatomic,strong) NSString *imageName3;
@property (nonatomic,strong) NSString *videoName;
@property (nonatomic,strong) NSString *userID;




//action=
//addTurnover&







@end


