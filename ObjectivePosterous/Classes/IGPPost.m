//
//  IGPPost.m
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月3日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import "IGPPost.h"
#import "ConciseKit.h"

@implementation IGPPost

@synthesize title, body, tags, autopost, source, isPrivate, media;

-(NSDictionary*) toParams {
    return $dict(title, @"post[title]",
                 body, @"post[body]",
                 tags, @"post[tags]",
                 autopost ? @"true" : @"false", @"post[autopost]",
                 source, @"post[source]",
                 isPrivate ? @"true" : @"false", @"post[is_private]",
                 media, @"media");
}

@end
