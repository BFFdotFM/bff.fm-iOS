//
//  RootPageViewController.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootPageViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (weak, nonatomic) UIPageControl *pageControl;
@end
