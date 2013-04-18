//
//  TeamViewController.h
//  InToads
//
//  Created by Max Roustan on 18/04/13.
//  Copyright (c) 2013 InTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *teamLabel;
@property (strong, nonatomic) IBOutlet UITextField *teamField;
@property (strong, nonatomic) IBOutlet UILabel *riderLabel;
@property (strong, nonatomic) IBOutlet UITextField *riderField;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIPickerView *selectionPicker;

@property (nonatomic) int selectedTextFieldTag;

@property (strong, nonatomic) NSMutableArray *teamsArray;
@property (strong, nonatomic) NSMutableArray *ridersArray;

- (IBAction)startAction:(id)sender;
@end
