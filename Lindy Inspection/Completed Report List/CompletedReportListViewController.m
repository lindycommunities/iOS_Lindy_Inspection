//
//  ViewController.m
//  Move In-Out
//
//  Created by S S D on 08/04/17.
//  Copyright © 2017 Move In-Out. All rights reserved.
//

#import "CompletedReportListViewController.h"
#import "CompletedReportListTableViewCell.h"
#import "MoveINPDFViewController.h"
#import "VideoPlayerViewController.h"
#import "MoveINPDFViewController1.h"

@interface CompletedReportListViewController ()

{
    NSArray *arrJobsList;

}

@end

@implementation CompletedReportListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
        [self GetAllData];
        
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)GetAllData{
    
    [self startLoading];

    
    
    [[WebServiceManager sharedInstance]GetAllCompletedReportWithSuccess:^(BaseResponse *result) {
        [self stopLoading];
        
        
        
        CompleteReportListResponse *response = (CompleteReportListResponse*)result;
        
        if (response.result.count) {
            arrJobsList = [[NSArray alloc]initWithArray:response.result];
            [self.TblALLData reloadData];
        }
            //levelID
        else{
            
            [self showToastForText:@"No Reports Found"];
            
        }

        
        
        
    } failure:^(CustomError *error) {
        [self stopLoading];
        
        //        [self showToastForText:@"Could not save data at the moment"];
        [self showToastForText:@"Oops Error Occured !"];
        
    }];
    

    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    
}
- (IBAction)GoBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
    
}






- (IBAction)MoveOUT_Click:(id)sender {
    
    //[self AskQuestion];
   // [self performSegueWithIdentifier:@"MoveOUT" sender:nil];

}
- (IBAction)Logout_Click:(id)sender{
    
   

}
#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.contentInset = UIEdgeInsetsZero;
    
    
    
    return [arrJobsList count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"selectionCell";
    CompletedReportListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        
        
        cell = [[CompletedReportListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    
    
    
    CompleteReport *item = [arrJobsList objectAtIndex:indexPath.row];
    // cell.textLabel.text = [item valueForKey:@"levelName"];
    cell.LblUnit_Property.text =[NSString stringWithFormat:@"%@",item.property];
   // cell.LblReportedBy.text =[NSString stringWithFormat:@"Reported By : %@",item.displayName];
    cell.LblDate.text =[NSString stringWithFormat:@"Date : %@",item.dateAdded];
    cell.LblOk.text =[NSString stringWithFormat:@"Time -> %@",item.timeOfIncident];
    //cell.LblNotOk.text =[NSString stringWithFormat:@"Not Ok -> %@",item.not_ok];
    
    
    cell.Btn_ViewRepost.tag=indexPath.row;
    [cell.Btn_ViewRepost addTarget:self action:@selector(OpenPDF:) forControlEvents:UIControlEventTouchUpInside];
    if(item.videoName.length){
        
        cell.Btn_ViewVideo.tag=indexPath.row;
        [cell.Btn_ViewVideo addTarget:self action:@selector(OpenVideo:) forControlEvents:UIControlEventTouchUpInside];
 
    }
    else
    {
        cell.Btn_ViewVideo.hidden=YES;

    }
    
    if((item.imageName1.length)||(item.imageName2.length)||(item.imageName3.length)){
        
        cell.Btn_ViewImages.tag=indexPath.row;
        [cell.Btn_ViewImages addTarget:self action:@selector(OpenImage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        cell.Btn_ViewImages.hidden=YES;
        
    }
    
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    }
-(void)OpenPDF:(UIButton*)Sender{
    
    CompleteReport *item = [arrJobsList objectAtIndex:Sender.tag];
//
    MoveINPDFViewController * dest = [self.storyboard instantiateViewControllerWithIdentifier:@"MoveINPDFViewController"];
    dest.PDFURL=item.pdfPath;
    [self.navigationController pushViewController:dest animated:YES];
//
    
    
}
-(void)OpenVideo:(UIButton*)Sender{
    
    CompleteReport *item = [arrJobsList objectAtIndex:Sender.tag];

    VideoPlayerViewController *videovc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoPlayerViewController"];
    videovc.videoURL = item.videoName;
    [self.navigationController pushViewController:videovc animated:YES];

    
}
-(void)OpenImage:(UIButton*)Sender{
    
    CompleteReport *item = [arrJobsList objectAtIndex:Sender.tag];
    //

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Choose Option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Image 1" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];

        if(item.imageName1.length){
        MoveINPDFViewController1 * dest = [self.storyboard instantiateViewControllerWithIdentifier:@"MoveINPDFViewController1"];
        dest.PDFURL=item.imageName1;
        [self.navigationController pushViewController:dest animated:YES];
        }
        else{
            
            [self showToastForText:@"Image not available"];
        }
        
        
        // Distructive button tapped.
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Image 2" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];

        // OK button tapped.
        if(item.imageName2.length){
            MoveINPDFViewController1 * dest = [self.storyboard instantiateViewControllerWithIdentifier:@"MoveINPDFViewController1"];
            dest.PDFURL=item.imageName2;
            [self.navigationController pushViewController:dest animated:YES];
        }
        else{
            
            [self showToastForText:@"Image not available"];
        }
        
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Image 3" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];

        // OK button tapped.
        if(item.imageName3.length){
            MoveINPDFViewController1 * dest = [self.storyboard instantiateViewControllerWithIdentifier:@"MoveINPDFViewController1"];
            dest.PDFURL=item.imageName3;
            [self.navigationController pushViewController:dest animated:YES];
        }
        else{
            
            [self showToastForText:@"Image not available"];
        }
    }]];
    
    // Present action sheet.
    
    
    UIPopoverPresentationController *popover = actionSheet.popoverPresentationController;
    if (popover)
    {
        popover.sourceView = Sender;
        popover.sourceRect = Sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
}

@end
