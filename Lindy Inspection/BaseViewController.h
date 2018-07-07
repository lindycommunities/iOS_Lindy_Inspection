//
//  BaseViewController.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 12/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceManager.h"

@interface BaseViewController : UIViewController{
    
@private

}
-(void)startLoading;
-(void)stopLoading;
-(void)showToastForText:(NSString *)text;
- (IBAction)backBtnPressed:(id)sender;
-(void)showToastForTextToast:(NSString *)text;
@end
