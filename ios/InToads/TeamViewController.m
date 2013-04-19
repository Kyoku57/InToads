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
@synthesize jsonResponse;

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
    
    [[HTTPRequests sharedInstance] sendGetTeamsListRequestWithDelegate:self];
    
    teamsArray = [NSMutableArray new];
    ridersArray = [NSMutableArray new];
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
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        [pickerView setFrame:CGRectMake(pickerView.frame.origin.x, pickerView.frame.origin.y+pickerView.frame.size.height, pickerView.frame.size.width, pickerView.frame.size.height)];
        
        [UIView commitAnimations];
    }
    
    pickerIsVisible = NO;
}

-(void)selectRow:(id)sender
{
    Team *team = [[CoreDataManager sharedInstance] getTeamForId:selectedRowFromPicker];
    selectedTextField.text = team.name;
    
    [[HTTPRequests sharedInstance] sendGetRidersListRequestForTeam:team.teamId WithDelegate:self];
 
    [self hidePicker:selectedTextField];
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    selectedRowFromPicker = @"";

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
        Team *team = (Team *) [teamsArray objectAtIndex:row];

        return team.name;
    }
    else if (selectedTextField == riderField)
    {
        Rider *rider = (Rider *) [ridersArray objectAtIndex:row];

        return rider.name;
    }
    else return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (selectedTextField == teamField)
    {
        Team *team = (Team *) [teamsArray objectAtIndex:row];

        selectedRowFromPicker = team.teamId;
    }
    else if (selectedTextField == riderField)
    {
        Rider *rider = (Rider *) [ridersArray objectAtIndex:row];

        selectedRowFromPicker = [ridersArray objectAtIndex:row];
    }
    
    //[self hidePicker:selectedTextField];
    
}

#pragma mark - NSURL Connection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // init json response
    jsonResponse = @"";
    
    // check response status
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    [[HTTPClient sharedInstance] handleResponseWithStatusCode:[resp statusCode] andURLPath:[[[response URL] relativePath] lastPathComponent]];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    jsonResponse = [jsonResponse stringByAppendingFormat:@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection error : %@", error);
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [[HTTPClient sharedInstance] presentLoadingHudWithTitle:NSLocalizedString(@"connection.error", @"Connection error") message:error.localizedDescription image:image andDelegate:self.view];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSDictionary *dictFromJSON = [[HTTPClient sharedInstance] handleResponseDataFromJSON:[jsonResponse dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"Dict from JSON : %@", dictFromJSON);
    
    if([connection.originalRequest.URL.lastPathComponent isEqualToString:@"teams"])
    {
        for (NSObject *object in dictFromJSON) {
            [[CoreDataManager sharedInstance] createOrUpdateTeamWithName:[object valueForKey:@"name"] forId:[object valueForKey:@"id"]];
            
            
        }
        
        [[CoreDataManager sharedInstance] storeData];
        
        teamsArray = [NSMutableArray arrayWithArray:[[CoreDataManager sharedInstance] getAllTeams]];
    }
    
    else if([connection.originalRequest.URL.lastPathComponent hasPrefix:@"team"])
    {
        NSString *teamId = connection.originalRequest.URL.lastPathComponent;
        for (NSObject *object in dictFromJSON) {
            [[CoreDataManager sharedInstance] createOrUpdateRiderWithName:[object valueForKey:@"name"] forId:[object valueForKey:@"id"] andTeamId:teamId];
        }
        
        [[CoreDataManager sharedInstance] storeData];
        
        ridersArray = [NSMutableArray arrayWithArray:[[CoreDataManager sharedInstance] getAllRidersForTeamId:teamId]];
    }
}

@end
