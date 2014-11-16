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
            
            // When an image does not exist, it is represented in the JSON as "Image: 0"
            id image = [dictionary objectForKey:@"Image"];
            if (image != nil && [image isKindOfClass:[NSDictionary class]]) {
                _image = [[Image alloc] initWithDictionary:image];
            }
        }
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Show: %@, url: %@>", self.title, self.url];
}
@end
