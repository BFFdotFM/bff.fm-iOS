#define EXP_SHORTHAND

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "CreekService.h"

SpecBegin(CreekService)

describe(@"CreekService", ^{
    it(@"should return a valid currently playing show", ^{
        waitUntil(^(DoneCallback done) {
            [[CreekService sharedService] fetchCurrentlyBroadcating:^(Show *show) {
                expect(show).notTo.beNil();
                
                expect(show.url).notTo.beNil();
                expect(show.url).notTo.equal(@"");

                expect(show.image).notTo.beNil();
                expect(show.image.smallUrl).notTo.beNil();
                expect(show.image.smallUrl).notTo.equal(@"");
                expect(show.image.mediumUrl).notTo.beNil();
                expect(show.image.mediumUrl).notTo.equal(@"");
                expect(show.image.largeUrl).notTo.beNil();
                expect(show.image.largeUrl).notTo.equal(@"");
                expect(show.image.originalUrl).notTo.beNil();
                expect(show.image.originalUrl).notTo.equal(@"");
                
                expect(show.shortDescription).notTo.beNil();
                expect(show.shortDescription).notTo.equal(@"");

                expect(show.title).notTo.beNil();
                expect(show.title).notTo.equal(@"");
                done();
            }];
        });
    });
    
    it(@"should return a valid set of shows", ^{
        waitUntil(^(DoneCallback done) {
            [[CreekService sharedService] fetchAllShows:^(NSArray *shows) {
                expect(shows).notTo.beNil();
                expect([shows count]).to.beGreaterThan(0);
                done();
            }];
        });
    });
});

SpecEnd
