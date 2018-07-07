//
//  VideosListTableViewCell.h
//  Level7Tennis
//
//  Created by Bonnie Jaiswal on 19/10/16.
//  Copyright © 2016 Bonnie Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedReportListTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *LblUnit_Property;
@property (nonatomic,weak)IBOutlet UILabel *LblReportedBy;
@property (nonatomic,weak)IBOutlet UILabel *LblDate;
@property (nonatomic,weak)IBOutlet UILabel *LblOk;
@property (nonatomic,weak)IBOutlet UILabel *LblNotOk;
@property (nonatomic,weak)IBOutlet UIButton *Btn_ViewRepost;
@property (nonatomic,weak)IBOutlet UIButton *Btn_ViewVideo;
@property (nonatomic,weak)IBOutlet UIButton *Btn_ViewImages;



@end
