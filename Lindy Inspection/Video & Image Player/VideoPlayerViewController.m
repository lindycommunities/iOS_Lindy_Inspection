//
//  VideoPlayerViewController.m
//  vzarTest
//
//  Created by Bonnie Jaiswal on 20/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import "VideoPlayerViewController.h"
@import AVFoundation;
@import AVKit;
#import "AppDelegate.h"

@interface VideoPlayerViewController ()
{
    AVPlayerViewController *playerViewController;
    BOOL slomoOn;
    
    AVPlayer * player;
    AppDelegate *delegate;
}

@property(nonatomic,weak)IBOutlet UINavigationBar *navBar;
@property(nonatomic,weak)IBOutlet UILabel *lblTitle;
@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.MessageHeader.text=self.Message;
    
    if ([AVAudioSession sharedInstance].otherAudioPlaying) {

        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    
    playerViewController = [[AVPlayerViewController alloc] init];
    
    NSURL *url = [NSURL URLWithString:self.videoURL];
    
    AVURLAsset *asset = [AVURLAsset assetWithURL: url];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
    
    player = [[AVPlayer alloc] initWithPlayerItem: item];
    playerViewController.player = player;
    [playerViewController.view setFrame:CGRectMake(0,self.ImgLogo.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.ImgLogo.frame.size.height)];//120
    
    playerViewController.showsPlaybackControls = YES;
    
    [self.view addSubview:playerViewController.view];
    [player play];
    
    

}
-(BOOL)shouldAutorotate{
    return YES;
    
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  //  NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskPortraitUpsideDown];
    //[[UIDevice currentDevice] setValue:value forKey:@"orientation"];

}

-(IBAction)slopmo:(id)sender{
    
    if (slomoOn) {
        playerViewController.player.rate = 1;
        slomoOn = NO;
        
    }
    else{
        playerViewController.player.rate = 0.5;
        slomoOn = YES;
        
    }
    
}


-(IBAction)dismissVIdeo:(id)sender{

    playerViewController.player =nil;
    playerViewController = nil;
    [self dismissViewControllerAnimated:self completion:nil];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//-(BOOL)shouldAutorotate{
//    
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;
//}

//-(NSUInteger)supportedInterfaceOrientations{
//    
//    
//    return UIInterfaceOrientationMaskAll;
//}

-(IBAction)ShareVIdeo:(id)sender{
        // grab an item we want to share
         NSString *theMessage = self.Message;
        NSArray *items = @[theMessage,self.videoURL];
        UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
        [self presentActivityController:controller];
    
    
    
}
- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
          //  [self showToastForText:@"Send successfully..."];
            
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
