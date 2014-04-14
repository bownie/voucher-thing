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
    [self unarchive];
}

// Archive the information we have in the CustomerData
//
- (void)archive
{
    NSLog(@"Archiving");
    
    // Load the data from the forms into the serializable object
    //
    CustomerData *cd = [CustomerData getInstance];
    cd.m_forename = self.firstNameTextField.text;
    cd.m_familyname = self.familyNameTextField.text;
    cd.m_email = self.emailTextField.text;
    
    if (self.sexText.selectedSegmentIndex == 1)
    {
        cd.m_sex = @"M";
    }
    else
    {
        cd.m_sex = @"F";
    }
    
    cd.m_town = self.townTextField.text;
    cd.m_postcode = self.postcodeTextField.text;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cd];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"customerData"];
}


// Unarchive the information for CustomerData
//
- (void)unarchive
{
    NSLog(@"Unarchiving");
    
    //CustomerData *cd = [CustomerData getInstance];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerData"];
    CustomerData *cd = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    // Attempt to fill the text fields
    //
    self.firstNameTextField.text = cd.m_forename;
    self.familyNameTextField.text = cd.m_familyname;
    
    if ([cd.m_sex isEqual: @"M"])
    {
        self.sexText.selectedSegmentIndex = 1;
    }
    else
    {
        self.sexText.selectedSegmentIndex = 2;
    }
    
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

-(void)textFieldDidEndEditing:(UITextField *) tf
{
    // Pull up the customer data
    //
    CustomerData *cd = [CustomerData getInstance];
    [cd saveData];
    
    NSLog(@"Text field edit complete - saving");
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
    NSLog(@"RESIGN ON TAP");
    
    // This works - all else fails
    //
    [self.view endEditing:YES];
    
    // For the moment force serialisation here
    //
    // Pull up the customer data
    //
    //CustomerData *cd = [CustomerData getInstance];
    //[cd saveData];
    
    [self archive];
    
    NSLog(@"Text field edit complete - saving");
}

- (BOOL)disablesAutomaticKeyboardDismissal { return NO; }

- (IBAction)dismissKeyboard {
	[self.currentResponder resignFirstResponder];
}

@end
