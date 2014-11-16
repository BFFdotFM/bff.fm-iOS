//
//  CreekService.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Show.h"

@interface CreekService : NSObject
+ (CreekService *)sharedService;

- (void)fetchCurrentlyBroadcating:(void (^) (Show *show))completionHandler;
@end
