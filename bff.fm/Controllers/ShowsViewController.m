//
//  ShowsViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "ShowsViewController.h"

@interface ShowsViewController ()
- (IBAction)popup:(id)sender;
@end

@implementation ShowsViewController
- (IBAction)popup:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailViewController"];
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"Done");
    }];
}
@end
