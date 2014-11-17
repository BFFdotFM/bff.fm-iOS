//
//  SupportViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()
- (IBAction)goToMerchStore:(id)sender;
- (IBAction)supportStation:(id)sender;
@end

@implementation SupportViewController

- (IBAction)goToMerchStore:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://bffdotfm.storenvy.com/"]];
}

- (IBAction)supportStation:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://bff.fm/support-us"]];
}

@end
