//
//  TeamViewController.m
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import "TeamViewController.h"


@implementation TeamViewController
@synthesize teamField, teamLabel, riderField, riderLabel, selectionPicker;
@synthesize teamsArray, ridersArray;
@synthesize selectedTextField;
@synthesize pickerIsVisible;
@synthesize selectedRowFromPicker;
@synthesize pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    teamsArray = [[NSMutableArray alloc] initWithObjects:@"Les Pinpins", @"Les Tintins", @"Les Zinzins", @"Les Pinpins", @"Les Tintins", @"Les Zinzins", nil];
    ridersArray = [[NSMutableArray alloc] initWithObjects:@"Pierre", @"Paul", @"Jacques", @"Pierre", @"Paul", @"Jacques", nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTeamLabel:nil];
    [self setTeamField:nil];
    [self setRiderLabel:nil];
    [self setRiderField:nil];
    [self setStartButton:nil];
    [self setSelectionPicker:nil];
    [self setPickerView:nil];
    [super viewDidUnload];
}
- (IBAction)startAction:(id)sender {
}

-(IBAction) showPicker:(id)sender
{
    if(!pickerIsVisible)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        [pickerView setFrame:CGRectMake(pickerView.frame.origin.x, pickerView.frame.origin.y-pickerView.frame.size.height, pickerView.frame.size.width, pickerView.frame.size.height)];
        
        [UIView commitAnimations];
    }
    
    pickerIsVisible = YES;
}

-(IBAction)hidePicker:(id)sender
{
    if (pickerIsVisible) {
        selectedTextField.text = selectedRowFromPicker;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        [pickerView setFrame:CGRectMake(pickerView.frame.origin.x, pickerView.frame.origin.y+pickerView.frame.size.height, pickerView.frame.size.width, pickerView.frame.size.height)];
        
        [UIView commitAnimations];
    }
    
    pickerIsVisible = NO;
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 2 && [teamField.text isEqualToString:@""])
    {
        return NO;
    }
    
    selectedTextField = textField;

    [selectionPicker reloadAllComponents];
    
    [self showPicker:textField];
    
    return NO;
}

#pragma mark - Picker Delegate Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (selectedTextField == teamField)
    {
        return [teamsArray count];
    }
    else if (selectedTextField == riderField)
    {
        return [ridersArray count];
    }
    else return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (selectedTextField == teamField)
    {
        return [teamsArray objectAtIndex:row];
    }
    else if (selectedTextField == riderField)
    {
        return [ridersArray objectAtIndex:row];
    }
    else return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (selectedTextField == teamField)
    {
        selectedRowFromPicker = [teamsArray objectAtIndex:row];
    }
    else if (selectedTextField == riderField)
    {
        selectedRowFromPicker = [ridersArray objectAtIndex:row];
    }
    
    //[self hidePicker:selectedTextField];
    
}

@end
