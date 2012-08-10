//
//  JamCallback.h
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppleJam;
@interface JamCallback : NSObject


@property(strong,nonatomic) NSString*uid;
@property(weak,nonatomic) AppleJam* jam;


- (void)sendBack:(NSString*)value;
- (void)sendBack:(NSString*)value clean:(BOOL)clean;
- (void)sendBackScript:(NSString*)script clean:(BOOL)clean;

@end


@interface JamParams : NSObject
+ (id)params:(id)params callback:(NSString*)uid jam:(AppleJam*)jam;
@property(strong) id params;
@property(strong) JamCallback* callback;
@end