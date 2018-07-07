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
@interface MoveINPDFViewController1 :BaseViewController<UIWebViewDelegate>{

    IBOutlet UIWebView *Web_view;

}
- (IBAction)GoBack:(id)sender;
@property(nonatomic,retain)NSString *PDFURL;
@property(nonatomic,retain)NSString *SourcePath;
@property(nonatomic,retain)NSURL *PDFURLPath;

@property(nonatomic,strong)NSString *Message;
@property(strong,nonatomic)IBOutlet UILabel *MessageHeader;
-(IBAction)ShareVIdeo:(id)sender;


@end

