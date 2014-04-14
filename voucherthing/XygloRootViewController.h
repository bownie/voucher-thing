//
//  XygloRootViewController.h
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface XygloRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;


- (void) keyboardDidShowNotification:(NSNotification *)aNotification;

@end
