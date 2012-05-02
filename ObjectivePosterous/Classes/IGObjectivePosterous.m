//
//  IGObjectivePosterous.m
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import "IGObjectivePosterous.h"
#import "JSONKit.h"
#import "JTObjectMapping/NSObject+JTObjectMapping.h"
#import "JTObjectMapping/JTMappings.h"
#import "IGPSite.h"
#import "ConciseKit.h"

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
                 if (_delegate && [_delegate respondsToSelector:@selector(posterous:loadSiteDidFailWithError:)]) {
                     [self.delegate posterous:self loadSiteDidFailWithError:error];
                 }
             }];

    [self enqueueOperation:op];
}

-(void) createPost:(IGPPost*)post withSiteId:(NSString*)siteId {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:[post toParams]];
    [params setObject:self.apiToken forKey:@"api_token"];
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"api/2/sites/%@/posts", siteId]
                                              params:params
                                          httpMethod:@"POST"
                                                 ssl:YES];
    
    [op setUsername:self.username password:self.password basicAuth:YES];
    [op onCompletion:^(MKNetworkOperation* completedOperation){
        if (_delegate && [_delegate respondsToSelector:@selector(posterous:createPostDidFinishWithFullUrl:)]) {
            NSData* data = [completedOperation responseData];
            NSDictionary* dictionary = [[JSONDecoder decoder] objectWithData:data];
            NSString* fullUrl = [dictionary objectForKey:@"full_url"];
            [self.delegate posterous:self
      createPostDidFinishWithFullUrl:fullUrl];
        }
    } 
             onError:^(NSError* error){
                 if (_delegate && [_delegate respondsToSelector:@selector(posterous:createPostDidFailWithError:)]) {
                     [self.delegate posterous:self createPostDidFailWithError:error];
                 }
             }];
    
    [self enqueueOperation:op];
}

-(void) dealloc {
    self.apiToken = nil;
    self.username = nil;
    self.password = nil;
}

@end