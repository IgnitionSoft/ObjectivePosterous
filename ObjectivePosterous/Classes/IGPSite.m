//
//  IGPSite.m
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月2日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import "IGPSite.h"

@implementation IGPSite

@synthesize fullHostname, hostname, name, siteId;

+(NSDictionary*) mappings {
    NSDictionary *mapping = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"siteId", @"id",
                             @"name", @"name",
                             @"hostname", @"hostname",
                             @"fullHostname", @"full_hostname",
                             nil];
    return mapping;
}

@end
