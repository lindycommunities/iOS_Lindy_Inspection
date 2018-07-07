//
//  ViewController.h
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BaseViewController.h"
@interface MoveINPDFViewController :BaseViewController<UIWebViewDelegate>{

    IBOutlet UIWebView *Web_view;

}
- (IBAction)GoBack:(id)sender;
@property(nonatomic,retain)NSString *PDFURL;
@property(nonatomic,retain)NSString *SourcePath;



@end

