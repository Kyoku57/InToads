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
    [super viewDidUnload];
}
- (IBAction)startAction:(id)sender {
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"TextField %i clicked", textField.tag);
    
    

    return NO;
}

@end
