//
//  StreamingService.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamingService : NSObject
+ (StreamingService *)sharedService;

- (void)play;
- (void)pause;
@end
