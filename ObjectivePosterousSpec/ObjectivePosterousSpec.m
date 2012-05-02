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
#import "IGPPost.h"

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
//            NSLog(@"delegate = %@", delegate);
//            __block NSArray* sites = nil;
//            [[delegate expect] posterous:posterous loadSiteDidFinish:[OCMArg checkWithBlock:^(NSArray* loadedSites){
//                NSLog(@"loaded sites: %@", loadedSites);
//                sites = loadedSites;
//                return YES;
//            }]];
//            [[delegate reject] posterous:posterous loadSiteDidFailWithError:[OCMArg any]];
//            
//            posterous.delegate = delegate;
//            [posterous loadSite];
//            
//            [$ waitUntil:^{ return (BOOL)(sites != nil); }];
//            
//            expect(sites).Not.toBeNil();
//            expect([sites count]).toBeGreaterThan(0);
//            IGPSite* site = [sites $first];
//            expect(site.name).Not.toBeNil();
//            expect(site.hostname).Not.toBeNil();
//            expect(site.fullHostname).Not.toBeNil();
//            expect(site.siteId).Not.toBeNil();
        });
    });
    
    
    describe(@"createPost", ^{
        it(@"should load sites", ^{
            NSLog(@"delegate = %@", delegate);
            __block NSString* url = nil;
            [[delegate expect] posterous:posterous createPostDidFinishWithFullUrl:[OCMArg checkWithBlock:^(NSString* _url){
                url = _url;
                return ((BOOL) (url != nil));
            }]];
             
            [[delegate reject] posterous:posterous createPostDidFailWithError:[OCMArg any]];
            
            posterous.delegate = delegate;
            
            IGPPost* post = [[IGPPost alloc] init];
            post.title = @"Automated Test Post";
            post.body = [@"testing body <img src='http://cp.ignt.hk/m/gcD72vPLXoq?open=true'>" stringByAppendingFormat:@"\n%@", [NSDate date]];
            [posterous createPost:post withSiteId:kPosterousSiteId];
            
            [$ waitUntil:^{ return (BOOL)(url != nil); }];
            expect(url).Not.toBeNil();
        });
    });
});
SpecEnd