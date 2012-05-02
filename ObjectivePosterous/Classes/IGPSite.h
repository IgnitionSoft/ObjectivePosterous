//
//  IGPSite.h
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGPSite : NSObject

@property (nonatomic, strong) NSString* fullHostname;
@property (nonatomic, strong) NSString* hostname;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* siteId;

+(NSDictionary*) mappings;

@end
