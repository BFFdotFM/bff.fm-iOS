//
//  RootViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "RootViewController.h"
#import "RootPageViewController.h"

@interface RootViewController ()
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[RootPageViewController class]]) {
        RootPageViewController *destination = segue.destinationViewController;
        destination.pageControl = self.pageControl;
    }
}

@end
