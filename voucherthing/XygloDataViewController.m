//
//  XygloDataViewController.m
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import "XygloDataViewController.h"
#import "CustomerData.h"

@interface XygloDataViewController ()

@end

@implementation XygloDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    // Attempt to remove keyboard with single tap outside the text areas
    //
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    //[singleTap release];
    
    // Pull up the customer data
    //
    CustomerData *cd = [CustomerData getInstance];

    // Attempt to fill the text fields
    //
    self.firstNameTextField.text = cd.m_forename;
    self.familyNameTextField.text = cd.m_familyname;
    self.emailTextField.text = cd.m_email;
    self.townTextField.text = cd.m_town;
    self.postcodeTextField.text = cd.m_postcode;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (void) keyboardDidShowNotification:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGFloat kbHeight =
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    NSString *string = [[NSString alloc] initWithFormat:@"keyboardDidShowNotification kbHeight: %.2f", kbHeight];
    NSLog(@"%@", string);
    //keyboardDidShowNotificationL.text = string;
    //[string release];
}

//Implement the below delegate method:

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

//Implement resignOnTap:

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

@end
