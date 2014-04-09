//
//  XygloModelController.h
//  pingvoucher
//
//  Created by Richard Bown on 09/04/2014.
//  Copyright (c) 2014 Xyglo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XygloDataViewController;

@interface XygloModelController : NSObject <UIPageViewControllerDataSource>

- (XygloDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(XygloDataViewController *)viewController;

@end
