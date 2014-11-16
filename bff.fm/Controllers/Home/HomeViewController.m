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
#import "StreamingService.h"

@interface HomeViewController ()
@property (strong, nonatomic) Show *show;

@property (strong, nonatomic) IBOutlet UIImageView *currentShowImage;
@property (strong, nonatomic) IBOutlet UILabel *currentShowTitle;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)doPlayPressed:(UIButton *)sender;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    
    [[CreekService sharedService] fetchCurrentlyBroadcating:^(Show *show) {
        [self setCurrentlyBroadcasting:show];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Set correct button state
    self.playButton.selected = [[StreamingService sharedService] isPlaying];
    
    [self setCurrentlyBroadcasting:self.show];
}

- (void)setCurrentlyBroadcasting:(Show *)show
{
    self.show = show;
    self.currentShowTitle.text = show.title;
    [self.currentShowImage sd_setImageWithURL:[NSURL URLWithString:show.image.originalUrl]];
}

#pragma mark - Actions
- (IBAction)doPlayPressed:(UIButton *)sender
{
    if ([self.playButton isSelected]) {
        [[StreamingService sharedService] pause];
        [self.playButton setSelected:NO];
    } else {
        [[StreamingService sharedService] play];
        [self.playButton setSelected:YES];
    }
}
@end
