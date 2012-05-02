//
//  ObjectivePosterousSpec.m
//  ObjectivePosterousSpec
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//
#import "Constants.h"
#import "OCMock/OCMock.h"
#import "ConciseKit/ConciseKit.h"
#import "Reachability.h"
#import "IGPSite.h"
#import "IGObjectivePosterous.h"

SpecBegin(ObjectivePosterousSpec)
describe(@"ObjectivePosterousSpec", ^{
    __block IGObjectivePosterous* posterous;
    __block OCMockObject<IGObjectivePosterousDelegate>* delegate;

    beforeEach(^{
        posterous = [[IGObjectivePosterous alloc] initWithApiToken:kPosterousApiToken
                                                          username:kPosterousUsername 
                                                          password:kPosterousPassword];

        delegate = [OCMockObject mockForProtocol:@protocol(IGObjectivePosterousDelegate)];
    });
    
    afterEach(^{
        posterous = nil;
        delegate = nil;
    });
    
    describe(@"loadSite", ^{
        it(@"should load sites", ^{
            NSLog(@"delegate = %@", delegate);
            __block NSArray* sites = nil;
            [[delegate expect] posterous:posterous loadSiteDidFinish:[OCMArg checkWithBlock:^(NSArray* loadedSites){
                NSLog(@"loaded sites: %@", loadedSites);
                sites = loadedSites;
                return YES;
            }]];
            [[delegate reject] posterous:posterous loadSiteFailedWithError:[OCMArg any]];
            
            posterous.delegate = delegate;
            [posterous loadSite];

            [$ waitUntil:^{ return (BOOL)(sites != nil); }];

            expect(sites).Not.toBeNil();
            expect([sites count]).toBeGreaterThan(0);
            IGPSite* site = [sites $first];
            expect(site.name).Not.toBeNil();
            expect(site.hostname).Not.toBeNil();
            expect(site.fullHostname).Not.toBeNil();
            expect(site.siteId).Not.toBeNil();
        });
    });
});
SpecEnd