//
//  IGObjectivePosterous.h
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit/MKNetworkEngine.h"

@class IGObjectivePosterous;

@protocol IGObjectivePosterousDelegate <NSObject>
@optional
-(void) posterous:(IGObjectivePosterous*)posterous loadSiteDidFinish:(NSArray*)sites;
-(void) posterous:(IGObjectivePosterous*)posterous loadSiteFailedWithError:(NSError*)error;
@end

@interface IGObjectivePosterous : MKNetworkEngine

@property (nonatomic, assign) id<IGObjectivePosterousDelegate> delegate;
@property (nonatomic, retain) NSString* apiToken;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* password;

-(id) initWithApiToken:(NSString*)apiToken username:(NSString*)username password:(NSString*)password;
-(void) loadSite;

@end
