//
//  IGPPost.h
//  ObjectivePosterous
//
//  Created by Francis Chong on 12年5月3日.
//  Copyright (c) 2012年 Ignition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGPPost : NSObject

@property (nonatomic, strong) NSString* title;

/** The post’s body  */
@property (nonatomic, strong) NSString* body;

/** Comma-delimited list of tags e.g. "apple, android"  **/
@property (nonatomic, strong) NSString* tags;

/** Set to true to autopost to external sites, or false otherwise **/
@property (nonatomic, assign) BOOL autopost;

/** The name of your application or website **/
@property (nonatomic, strong) NSString* source;

/** Set to true to make this post private, or false to make it public  **/
@property (nonatomic, assign) BOOL isPrivate;

/** An array of media to attach to the post. Images will be converted to a gallery.  **/
@property (nonatomic, strong) NSArray* media;

-(NSDictionary*) toParams;

@end
