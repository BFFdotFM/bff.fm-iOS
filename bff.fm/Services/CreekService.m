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

@end
