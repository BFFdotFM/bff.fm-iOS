//
//  HomeViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "HomeViewController.h"
#import "CreekService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeViewController ()
@property (strong, nonatomic) Show *show;

@property (strong, nonatomic) IBOutlet UIImageView *currentShowImage;
@property (strong, nonatomic) IBOutlet UILabel *currentShowTitle;
@property (strong, nonatomic) IBOutlet UITextField *currentShowDescription;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CreekService sharedService] fetchCurrentlyBroadcating:^(Show *show) {
        [self setCurrentlyBroadcasting:show];
    }];
}

- (void)setCurrentlyBroadcasting:(Show *)show
{
    self.show = show;
    self.currentShowTitle.text = show.title;
    [self.currentShowImage sd_setImageWithURL:[NSURL URLWithString:show.image.originalUrl]];
}
@end
