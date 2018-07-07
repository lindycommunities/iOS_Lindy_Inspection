//
//  Video.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "BaseModel.h"

@protocol CompleteReport <NSObject>
@end

@interface CompleteReport : BaseModel

@property (nonatomic) NSString *dateAdded;
@property (nonatomic) NSString *pdfPath;
@property (nonatomic) NSString *property;
@property (nonatomic) NSString *timeOfIncident;
@property (nonatomic) NSString *videoName;
@property (nonatomic) NSString *imageName1;
@property (nonatomic) NSString *imageName2;
@property (nonatomic) NSString *imageName3;





@end
