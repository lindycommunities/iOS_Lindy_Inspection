//
//  ViewController.h
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CompletedReportListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    int counterData,AttemptCount;

}

@property(nonatomic,weak)IBOutlet UITableView *TblALLData;
@property(nonatomic,retain)NSString *form_id;
@property(nonatomic,retain)NSString *moveInOutType;
@property(nonatomic,retain)NSMutableArray *arrAllData;
@property(nonatomic,retain)NSMutableArray *arrOKAllData;
@property(nonatomic,assign)int *currentIndex;
@property(nonatomic,retain)NSArray *AllTechnicianData;
@property(nonatomic, assign)CompleteReport *item;
@property(nonatomic,retain)NSString *SourcePath;
@property(nonatomic,weak)IBOutlet UILabel *LblMessage;


@end

