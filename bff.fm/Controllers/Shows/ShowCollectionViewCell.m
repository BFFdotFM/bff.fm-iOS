//
//  ShowCollectionViewCell.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "ShowCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShowCollectionViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *showTitle;
@property (strong, nonatomic) IBOutlet UILabel *showTime;

@property (strong, nonatomic) Show *show;
@end

@implementation ShowCollectionViewCell
- (void)setShow:(Show *)show
{
    _show = show;
    [self.showImage sd_setImageWithURL:[NSURL URLWithString:show.image.smallUrl]];
    self.showTitle.text = show.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    self.self.showTime.text = [NSString stringWithFormat:@"%@ - %@", [formatter stringFromDate:show.start], [formatter stringFromDate:show.end]];
}

- (void)prepareForReuse
{
    _show = nil;
    [self.showImage setImage:nil];
    self.showTitle.text = @"";
}
@end
