//
//  XygloDataViewController.m
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import "XygloDataViewController.h"

@interface XygloDataViewController ()

@end

@implementation XygloDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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


@end
