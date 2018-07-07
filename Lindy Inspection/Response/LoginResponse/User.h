//
//  Video.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseResponse.h"

@protocol User <NSObject>
@end

@interface User : BaseResponse

@property (nonatomic) NSString *userID;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *roleAID;




//message = "Login successfully.";
//result =     {
//    address1 = "";
//    cityID = 0;
//    dateOfBirth = "0000-00-00";
//    email = "virat@kohli.com";
//    firstName = Virat;
//    gender = Male;
//    lastName = Kohli;
//    phone = 1234567890;
//    stateID = 0;
//    userID = 5;
//    userName = "";
//    userTypeID = 3;
//    zipcode = "";
//};
//success = true;



@end
