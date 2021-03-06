//
//  XygloRootViewController.m
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import "XygloRootViewController.h"

#import "XygloModelController.h"

#import "XygloDataViewController.h"

@interface XygloRootViewController ()
@property (readonly, strong, nonatomic) XygloModelController *modelController;
@property CLBeaconRegion * region;

@end

@implementation XygloRootViewController

// iBeacon company id
static NSString * myCompanyIdentifier = @"com.xyglo.voucherthing";
static CLBeaconMajorValue myCompanyMajor = 1;
static CLBeaconMinorValue myCompanyMinor = 1;
static CLBeaconRegion *region;

@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    XygloDataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = self.modelController;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    // instantiate new iBeacon region
    NSUUID *myUUID = [[NSUUID alloc] initWithUUIDString:@"90E5A922-8A06-4A5F-9DE7-E7744A29B634"];
    region = [[CLBeaconRegion alloc] initWithProximityUUID:myUUID
                                                     major:myCompanyMajor
                                                     minor:myCompanyMinor
                                                     identifier:myCompanyIdentifier];
    
    // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
    [self.region setNotifyEntryStateOnDisplay:YES];
    [self.region setNotifyOnEntry:YES];
    [self.region setNotifyOnExit:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (XygloModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[XygloModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
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

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    NSLog(@"DID ENTER REGION");
    
    /*
    // notify user they have entered the region
    if ([region.identifier isEqualToString:myCompanyIdentifier]
    	&& !self.didShowEntranceNotifier) {
        
        // Optionally notify user they have entered the region
        self.didShowEntranceNotifier = YES;
        
        // start tracking beacons
        [manager startRangingBeaconsInRegion:self.targetRegion];
    }*/
}



@end
