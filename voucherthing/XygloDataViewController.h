//
//  XygloDataViewController.h
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XygloDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

//declare a property to store your current responder
//
@property (nonatomic, assign) id currentResponder;


// IBOutlets to be hooked up to the UI
//
@property (nonatomic,weak) IBOutlet UITextField *firstNameTextField;
@property (nonatomic,weak) IBOutlet UITextField *familyNameTextField;
@property (nonatomic,weak) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexText;
@property (nonatomic,weak) IBOutlet UITextField *sexTextField;
@property (nonatomic,weak) IBOutlet UITextField *townTextField;
@property (nonatomic,weak) IBOutlet UITextField *postcodeTextField;

- (void) keyboardDidShowNotification:(NSNotification *)aNotification;


- (BOOL)disablesAutomaticKeyboardDismissal;



@end
