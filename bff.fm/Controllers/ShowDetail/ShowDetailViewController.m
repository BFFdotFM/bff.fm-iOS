//
//  ShowDetailViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "ShowDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShowDetailViewController () <UIWebViewDelegate>
@property (strong, nonatomic) Show *show;

@property (strong, nonatomic) IBOutlet UILabel *showTitle;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UIWebView *showDescription;

- (IBAction)close:(UIButton *)sender;
@end

@implementation ShowDetailViewController

- (void)setShow:(Show *)show
{
    _show = show;
    [self updateState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.showDescription.delegate = self;
    [self updateState];
}

#pragma mark - Actions

- (IBAction)close:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebVewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked){
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    return YES;
}

#pragma mark - Utility
- (void)updateState
{
    if (!self.show) { return; }
    
    [self.showImage sd_setImageWithURL:[NSURL URLWithString:self.show.image.largeUrl]];
    self.showTitle.text = self.show.title;
    [self.showDescription loadHTMLString:self.show.fullDescription baseURL:nil];
}

@end
