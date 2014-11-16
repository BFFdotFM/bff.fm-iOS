//
//  Show.h
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image.h"

NS_ENUM(NSInteger, WeekDay) {
    NotADay = 0,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
};

#define WeekDayLabels @[@"Not a day", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"]

@interface Show : NSObject
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) Image *image;

@property (nonatomic, assign) enum WeekDay day;
@property (strong, nonatomic) NSDate *start;
@property (strong, nonatomic) NSDate *end;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
