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
            _fullDescription = [dictionary objectForKey:@"full_description"];
            
            
            // When an image does not exist, it is represented in the JSON as "Image: 0"
            id image = [dictionary objectForKey:@"Image"];
            if (image != nil && [image isKindOfClass:[NSDictionary class]]) {
                _image = [[Image alloc] initWithDictionary:image];
            }
            
            if ([[dictionary allKeys] containsObject:@"Airtime"]) {
                NSDictionary *airtime = [dictionary objectForKey:@"Airtime"];
                _day = [[airtime objectForKey:@"weekday"] intValue];

                NSString *startGMT = [airtime objectForKey:@"start_date_time_gmt"];
                NSString *endGMT = [airtime objectForKey:@"end_date_time_gmt"];

                NSDateFormatter *formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
                
                _start = [formatter dateFromString:[NSString stringWithFormat:@"%@-0000", startGMT]];
                _end = [formatter dateFromString:[NSString stringWithFormat:@"%@-0000", endGMT]];
            } else if ([[dictionary allKeys] containsObject:@"airtimes"]) {
                NSArray *airtimes = [dictionary objectForKey:@"airtimes"];
                if ([airtimes count] > 0) {
                    NSDictionary *airtime = [airtimes objectAtIndex:0];
                    _day = [[airtime objectForKey:@"weekday"] intValue];
                    
                    NSString *startGMT = [airtime objectForKey:@"start_gmt"];
                    NSString *endGMT = [airtime objectForKey:@"end_gmt"];
                    
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    [formatter setDateFormat:@"HH:mm:ssZ"];
                    
                    _start = [formatter dateFromString:[NSString stringWithFormat:@"%@-0000", startGMT]];
                    _end = [formatter dateFromString:[NSString stringWithFormat:@"%@-0000", endGMT]];
                }
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
