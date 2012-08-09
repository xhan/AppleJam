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
    [_jam runScript: script];
}

- (void)sendBackScript:(NSString*)script clean:(BOOL)clean
{
    [_jam runScript:[NSString stringWithFormat:
                     @"Jam.callback(%@,%d,%@)",_uid,clean,script] ];
}
@end
