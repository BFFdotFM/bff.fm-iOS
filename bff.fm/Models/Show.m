//
//  Show.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "Show.h"

@implementation Show
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (dictionary) {
            _title = [dictionary objectForKey:@"title"];
            _url = [dictionary objectForKey:@"url"];
            _shortDescription = [dictionary objectForKey:@"short_description"];
            _image = [[Image alloc] initWithDictionary:[dictionary objectForKey:@"Image"]];
        }
    }
    
    return self;
}
@end
