//
//  AWSelectionViewController.m
//  AxisWallet
//
//  Created by Avin More on 30/06/15.
//  Copyright (c) 2015 AgreeYa Mobility. All rights reserved.
//

#import "SLSelectionViewController.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface SLSelectionViewController ()
{
    BOOL playerFlag;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *titleNavBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel; // if cancel needs to be hidden
@property (strong, nonatomic) IBOutlet UIBarButtonItem *DoneButton;

@property(nonatomic,strong) NSArray *filteredArray;
@end

@implementation SLSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add listner to search text field to search city name and update picker selection
    [self.searchTextField addTarget:self action:@selector(searchForMatchingCity:) forControlEvents:UIControlEventEditingChanged];
    [self.searchTextField addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
    // Do any additional setup after loading the view.
    
    if (self.titleForSelection) {
        self.searchTextField.placeholder = self.titleForSelection;
        self.titleNavBar.topItem.title = self.titleForSelection;
    }
    if (self.hideCancel) {
        [self.btnCancel setEnabled:NO];
        [self.btnCancel setTintColor: [UIColor clearColor]];
    }
    [self.searchTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.searchTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    self.searchTextField.delegate = self;
    
    
    if(!self.selectedIndexValue){
    self.selectedIndexValue=[[NSMutableArray alloc]init];
    self.selectedIndexDictionary = [NSMutableDictionary dictionary];

    }
    
    if(_isMutliSelect){
        
        self.searchTextField.hidden=YES;
        self.filteredArray = self.itemList;



    }
    else
    {
        [self.DoneButton setEnabled:NO];
        [self.DoneButton setTintColor: [UIColor clearColor]];
        
        if(self.isSortAllow){
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:self.displayItemKey ascending:YES];
        self.filteredArray = [self.itemList sortedArrayUsingDescriptors:@[sortDescriptor]];
        }
        else
        {
            self.filteredArray = self.itemList;
        }


    }
    
    if([self.titleForSelection isEqualToString:@"Select"]){
        
        self.ViewSearchBar.hidden=YES;

    }
    else
    {
        self.ViewSearchBar.hidden=NO;

    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TABLE_DELEGATE_DATASOURSE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    tableView.contentInset = UIEdgeInsetsZero;
    return [self.filteredArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"selectionCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (self.selectedIndexDictionary[indexPath] != nil) cell.accessoryType = UITableViewCellAccessoryCheckmark;


        BaseModel *item = [self.filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [item valueForKey:self.displayItemKey];
    
    if (self.subtitleDisplayItemKey.length) {
        cell.detailTextLabel.text = [item valueForKey:self.subtitleDisplayItemKey];
    }
    else
    {
        cell.detailTextLabel.text=@"";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchTextField resignFirstResponder];
    
    if(_isMutliSelect){
        
        if (self.selectedIndexDictionary[indexPath] == nil) {
            [self.selectedIndexDictionary setObject:self.filteredArray[indexPath.row] forKey:indexPath];
            
            
            [self.selectedIndexValue addObject:self.filteredArray[indexPath.row]];
            
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];

        }else{
            [self.selectedIndexDictionary removeObjectForKey:indexPath];
            [self.selectedIndexValue removeObject:self.filteredArray[indexPath.row]];
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        }
        
    }
    else
    {
    
    if (_delegate) {
        [self dismissViewControllerAnimated:YES completion:^{
            if(_delegate && [_delegate respondsToSelector:@selector(didSelectItem:)]) {
                NSDictionary *item = [self.filteredArray objectAtIndex:indexPath.row];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate didSelectItem:item];
                });
            }
        }];
    }
    }
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)DoneButtonPressed:(UIBarButtonItem *)sender {
    if (_delegate) {
        [self dismissViewControllerAnimated:YES completion:^{
            if(_delegate && [_delegate respondsToSelector:@selector(didSelectMultipleItem:andIndexes:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_delegate didSelectMultipleItem:self.selectedIndexValue andIndexes:self.selectedIndexDictionary];
                });
            }
        }];
    }
}

#pragma mark - FILTER
/*!
 @brief Search maching city name in city_name list and set picker accordingly.
 */

-(void)searchForMatchingCity:(UITextField *)textField
{
    
    if([textField.text length] && [self.itemList count]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.%@ BEGINSWITH[c] %@)",self.displayItemKey,textField.text];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:self.displayItemKey ascending:YES];

        self.filteredArray = [[self.itemList filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[sortDescriptor]];
//        if(!self.filteredArray.count){
////            [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid City" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//
//        }
        [self.tableView reloadData];
        
    }
    else
    {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:self.displayItemKey ascending:YES];
        self.filteredArray = [self.itemList sortedArrayUsingDescriptors:@[sortDescriptor]];

        [self.tableView reloadData];
    }
}

-(void)doneAction:(UITextField *)sender {
    [self.searchTextField resignFirstResponder];
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
