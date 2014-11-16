//
//  Image.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "Image.h"

@implementation Image
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (dictionary) {
            _smallUrl = [dictionary objectForKey:@"url_sm"];
            _mediumUrl = [dictionary objectForKey:@"url_md"];
            _largeUrl = [dictionary objectForKey:@"url_lg"];
            _originalUrl = [dictionary objectForKey:@"url"];
        }
    }
    
    return self;
}
@end
