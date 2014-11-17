//
//  ShowsViewController.m
//  bff.fm
//
//  Created by Brian Temple on 11/15/14.
//  Copyright (c) 2014 bff.fm. All rights reserved.
//

#import "ShowsViewController.h"
#import "CreekService.h"
#import "Show.h"
#import "ShowCollectionViewCell.h"
#import "WeekdayHeaderCollectionReusableView.h"
#import "ShowDetailViewController.h"

@interface ShowsViewController ()
@property (strong, nonatomic) NSDictionary *shows;

@property (strong, nonatomic) NSArray *days;
@end

@implementation ShowsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [[CreekService sharedService] fetchAllShows:^(NSArray *allShows) {
        NSMutableDictionary *shows = [NSMutableDictionary new];
        
        for (Show *show in allShows) {
            if (show.day != NotADay) {
                if (![[shows allKeys] containsObject:@(show.day)]) {
                    [shows setObject:[NSMutableArray new] forKey:@(show.day)];
                }
                
                NSMutableArray *dayArray = [shows objectForKey:@(show.day)];
                
                NSUInteger index = [dayArray indexOfObject:show
                                             inSortedRange:(NSRange){0, [dayArray count]}
                                                   options:NSBinarySearchingInsertionIndex
                                           usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                               
                                               NSDate *left = ((Show *) obj1).start;
                                               NSDate *right = ((Show *) obj2).start;
                                               
                                               NSCalendar *calendar = [NSCalendar currentCalendar];
                                               NSDateComponents *leftComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:left];
                                               NSInteger leftMinutes = ([leftComponents hour] * 60) + [leftComponents minute];
                                               
                                               NSDateComponents *rightComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:right];
                                               NSInteger rightMinutes = ([rightComponents hour] * 60) + [rightComponents minute];
                                               
                                               if (leftMinutes < rightMinutes) {
                                                   return NSOrderedAscending;
                                               } else if (leftMinutes > rightMinutes) {
                                                   return NSOrderedDescending;
                                               }
                                               return NSOrderedSame;
                                           }];
                [dayArray insertObject:show atIndex:index];
            }
        }
        
        self.shows = shows;
        [self.collectionView reloadData];
        
         NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
         NSDateComponents *dateComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
        
        // Creek.fm starts on Monday
        enum WeekDay currentDay = Sunday - [dateComponents weekday] + 1;
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:(currentDay - 1)]
                                    atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        WeekdayHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader" forIndexPath:indexPath];
        
        NSString *title = [[NSString alloc]initWithFormat:@"%@", [WeekDayLabels objectAtIndex:((NSUInteger)[self sectionToWeekDay:indexPath.section])]];
        headerView.title.text = title;
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return (NSInteger) [[self.shows allKeys] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (NSInteger) [[self.shows objectForKey:@([self sectionToWeekDay:section])] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShowCollectionViewCell" forIndexPath:indexPath];
    [cell setShow:[self showForIndexPath:indexPath]];
    return cell;
}

- (NSInteger)sectionToWeekDay:(NSInteger)section
{
    return section + 1;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShowDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowDetailViewController"];
    [vc setShow:[self showForIndexPath:indexPath]];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Utility
- (Show *)showForIndexPath:(NSIndexPath *)indexPath
{
    int day = (int)[self sectionToWeekDay:indexPath.section];
    return [[self.shows objectForKey:@(day)] objectAtIndex:((NSUInteger)indexPath.row)];
}
@end
