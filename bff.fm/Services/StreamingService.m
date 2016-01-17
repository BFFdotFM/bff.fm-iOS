//
//  StreamingService.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "StreamingService.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AudioToolbox/AudioToolbox.h>

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
        [sharedService loadPlayer:nil];
    });
    
    return sharedService;
}

- (void)loadPlayer:(void (^)(BOOL success))completionHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://bff.fm/api/station" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSURL *url = [NSURL URLWithString:[responseObject objectForKey:@"stream_url"]];
        
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        //[self.playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (completionHandler) { completionHandler(YES); }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (completionHandler) { completionHandler(NO); }
    }];
}

- (BOOL)isPlaying
{
    if (self.player == nil) { return NO; }
    return (self.player.rate > 0 && !self.player.error);
}

- (void)play
{
    if (self.player == nil) {
        [self loadPlayer:^(BOOL success) {
            if (success) { [self.player play]; }
        }];
    } else {
        [self.player play];
    }
}

- (void)pause
{
    if (self.player) {
        [self.player pause];
    }
}

@end
