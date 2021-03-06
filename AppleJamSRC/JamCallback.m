//
//  JamCallback.m
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "JamCallback.h"
#import "AppleJam.h"

@implementation JamCallback


- (void)sendBack:(NSString*)value
{
    [self sendBack:value clean:YES];
}
- (void)sendBack:(NSString*)value clean:(BOOL)clean
{
    id script = [NSString stringWithFormat:
                 @"Jam.callback(%@,%d,'%@')",_uid,clean,value];
    NSLog(@"%@",script);
    dispatch_async(dispatch_get_main_queue(), ^{
        [_jam runScript: script];
    });
    
}

- (void)sendPure:(NSString*)pure clean:(BOOL)clean
{
    
    id script = [NSString stringWithFormat:
                 @"Jam.callback(%@,%d,%@)",_uid,clean,pure];
    NSLog(@"%@",script);
    dispatch_async(dispatch_get_main_queue(), ^{
        [_jam runScript: script];
    });
}

@end



@implementation JamParams

+ (id)params:(id)params callback:(NSString*)uid jam:(AppleJam*)jam
{
    JamParams* p = [[JamParams alloc] init];
    
    JamCallback*callback = [[JamCallback alloc] init];
    callback.uid = uid;
    callback.jam = jam;

    p.params = params;
    p.callback = callback;
    II_RELEASE(callback);
    return II_AUTORELEASE(p);
}

@end