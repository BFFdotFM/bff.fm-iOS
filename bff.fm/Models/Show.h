//
//  Show.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

@interface Show : NSObject
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) Image *image;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
