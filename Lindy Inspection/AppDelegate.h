//
//  AppDelegate.h
//  Lindy Inspection
//
//  Created by S S D on 24/02/18.
//  Copyright © 2018 Lindy Inspection. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmitIncidentReportRequest.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SubmitIncidentReportRequest *addRequest;


@end

