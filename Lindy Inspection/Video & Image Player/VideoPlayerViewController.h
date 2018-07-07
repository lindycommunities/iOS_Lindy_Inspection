//
//  VideoPlayerViewController.h
//  vzarTest
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface VideoPlayerViewController : BaseViewController

@property(nonatomic,strong)NSString *videoURL;
@property(nonatomic,strong)NSString *Message;
@property(strong,nonatomic)IBOutlet UILabel *MessageHeader;
@property(strong,nonatomic)IBOutlet UIButton *BtnMenu;
@property(strong,nonatomic)IBOutlet UIImageView *ImgLogo;

-(IBAction)ShareVIdeo:(id)sender;

@end
