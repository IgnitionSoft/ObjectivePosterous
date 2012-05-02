//
//  IGObjectivePosterous.m
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import "Reachability.h"
#import "IGObjectivePosterous.h"
#import "JSONKit.h"
#import "JTObjectMapping/NSObject+JTObjectMapping.h"
#import "JTObjectMapping/JTMappings.h"
#import "IGPSite.h"
#import "ConciseKit.h"

#define kPosterousUrlBase @"http://posterous.com/api/2"
@interface IGObjectivePosterous(Private)
-(NSString*) urlWithPath:(NSString*)path;
@end

@implementation IGObjectivePosterous

@synthesize apiToken = _apiToken, username = _username, password = _password;
@synthesize delegate = _delegate;

-(id) initWithApiToken:(NSString*)apiToken username:(NSString*)username password:(NSString*)password {
    self = [super initWithHostName:@"posterous.com" customHeaderFields:[NSDictionary dictionary]];
    if (self) {
        self.apiToken = apiToken;
        self.username = username;
        self.password = password;
    }
    return self;
}

-(void) loadSite {
    MKNetworkOperation *op = [self operationWithPath:@"api/2/sites" 
                                              params:$dict(self.apiToken, @"api_token")
                                          httpMethod:@"GET"
                                                 ssl:YES];
    [op setUsername:self.username password:self.password basicAuth:YES];
    [op onCompletion:^(MKNetworkOperation* completedOperation){
        NSLog(@"completed op: %@", completedOperation);
        if (_delegate && [_delegate respondsToSelector:@selector(posterous:loadSiteDidFinish:)]) {
            NSData* data = [completedOperation responseData];
            NSDictionary* dictionary = [[JSONDecoder decoder] objectWithData:data];
            NSArray* sites = [IGPSite objectFromJSONObject:dictionary 
                                                   mapping:[IGPSite mappings]];
            [self.delegate posterous:self 
                   loadSiteDidFinish:sites];
        }
    } 
             onError:^(NSError* error){
                 NSLog(@"error: %@", error);
                 if (_delegate && [_delegate respondsToSelector:@selector(posterous:loadSiteFailedWithError:)]) {
                     [self.delegate posterous:self 
                      loadSiteFailedWithError:error];
                 }
             }];

    [self enqueueOperation:op];
}

-(void) dealloc {
    self.apiToken = nil;
    self.username = nil;
    self.password = nil;
}

#pragma mark - Private

-(NSString*) urlWithPath:(NSString*)path {
    return [NSString stringWithFormat:@"%@/%@", kPosterousUrlBase, path];
}

@end