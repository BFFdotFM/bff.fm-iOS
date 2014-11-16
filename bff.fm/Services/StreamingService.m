//
//  StreamingService.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "StreamingService.h"
#import <AVFoundation/AVFoundation.h>

@interface StreamingService ()
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *player;
@end

@implementation StreamingService
+ (StreamingService *)sharedService
{
    static StreamingService *sharedService;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedService = [[self alloc] init];
        NSURL *url = [NSURL URLWithString:@"http://54.200.3.150:8232/stream.mp3"];
        
        sharedService.playerItem = [AVPlayerItem playerItemWithURL:url];
        //[sharedService.playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
        sharedService.player = [AVPlayer playerWithPlayerItem:sharedService.playerItem];
    });
    
    return sharedService;
}

- (BOOL)isPlaying
{
    return (self.player.rate > 0 && !self.player.error);
}

- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

@end
