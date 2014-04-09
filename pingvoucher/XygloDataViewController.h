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

- (void) keyboardDidShowNotification:(NSNotification *)aNotification;

@end
