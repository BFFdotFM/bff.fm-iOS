//
//  Image.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property (strong, nonatomic) NSString *smallUrl;
@property (strong, nonatomic) NSString *mediumUrl;
@property (strong, nonatomic) NSString *largeUrl;
@property (strong, nonatomic) NSString *originalUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
