//
//  CreekService.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "CreekService.h"
#import <AFNetworking/AFNetworking.h>

@implementation CreekService
+ (CreekService *)sharedService
{
    static CreekService *sharedService;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedService = [[self alloc] init];
    });
    
    return sharedService;
}

- (void)fetchCurrentlyBroadcating:(void (^) (Show *show))completionHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://bff.fm/api/broadcasting" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *now = [responseObject objectForKey:@"now"];
        Show *show = [[Show alloc] initWithDictionary:now];
        completionHandler(show);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(nil);
    }];
}

- (void)fetchAllShows:(void (^) (NSArray *shows))completionHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://bff.fm/api/shows" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *shows = [NSMutableArray new];
        for (NSDictionary *show in ((NSArray *)responseObject)) {
            NSLog(@"\n\nShow: %@", show);
            [shows addObject:[[Show alloc] initWithDictionary:show]];
        }
        
        completionHandler(shows);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(nil);
    }];
}

@end
