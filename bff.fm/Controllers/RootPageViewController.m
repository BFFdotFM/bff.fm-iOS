//
//  RootPageViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "RootPageViewController.h"

@interface RootPageViewController ()
@property (strong, nonatomic) NSArray *viewControllers;
@end

@implementation RootPageViewController
@synthesize viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewControllers = @[
                             [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"EventsViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"SupportViewController"]
                             ];
    [self setViewControllers:@[[self.viewControllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.delegate = self;
    self.dataSource = self;
    [self.pageControl setNumberOfPages:((NSInteger)[self.viewControllers count])];
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    self.doubleSided = NO;
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

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSUInteger currentIndex = [self.viewControllers indexOfObject:[pendingViewControllers objectAtIndex:0]];
    [self.pageControl setCurrentPage:((NSInteger)currentIndex)];
}

@end
