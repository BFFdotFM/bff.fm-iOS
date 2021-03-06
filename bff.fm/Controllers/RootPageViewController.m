//
//  RootPageViewController.m
//  bff.fm
//
//  Modified by Forrest Guest on 2015-01-17.
//  Copyright (c) 2015 bff.fm. All rights reserved.
//

#import "RootPageViewController.h"

@interface RootPageViewController ()
@property (strong, nonatomic) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger currentPageIndex;
@end

@implementation RootPageViewController
@synthesize viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewControllers = @[
                             [self.storyboard instantiateViewControllerWithIdentifier:@"SupportViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"ShowsViewController"]
                             ];
    self.currentPageIndex = 1;
    [self setViewControllers:@[[self.viewControllers objectAtIndex:((NSUInteger)self.currentPageIndex)]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.pageControl setCurrentPage:self.currentPageIndex];
    self.delegate = self;
    self.dataSource = self;
    [self.pageControl setNumberOfPages:((NSInteger)[self.viewControllers count])];
}

- (void)setPageControl:(UIPageControl *)pageControl
{
    _pageControl = pageControl;
    [_pageControl setCurrentPage:self.currentPageIndex];
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
    self.currentPageIndex = (NSInteger)[self.viewControllers indexOfObject:[pendingViewControllers objectAtIndex:0]];
    [self.pageControl setCurrentPage:self.currentPageIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed == NO) {
        self.currentPageIndex = (NSInteger)[self.viewControllers indexOfObject:[previousViewControllers objectAtIndex:0]];
        [self.pageControl setCurrentPage:self.currentPageIndex];
    }
}


@end
