//
//  RootViewController.m
//  ios
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "RootViewController.h"

#import "HomeViewController.h"
#import "ShowsViewController.h"
#import "EventsViewController.h"
#import "SupportViewController.h"

@interface RootViewController ()
@property (strong, nonatomic) NSArray *viewControllers;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    self.viewControllers = @[
                             [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"EventsViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"SupportViewController"]
                             ];
    [self.pageViewController setViewControllers:@[[self.viewControllers objectAtIndex:0] ] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = self;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - UIPageViewControllerDataSource delegate methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self.viewControllers objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.viewControllers count]) {
        return nil;
    }
    
    return [self.viewControllers objectAtIndex:index];
}

@end
