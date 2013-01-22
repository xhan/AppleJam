//
//  MainViewBridge.m
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "MainViewBridge.h"
#import "JamCallback.h"


@implementation MainViewBridge
{
    NSTimer*timer;
    int updates;
    JamCallback* callbackUpdates;
}
- (void)messagesend:(JamParams*)param
{
    [_delegate messagesend:param.params];
}
- (void)getvalue:(JamParams*)param
{
    static int i = 0;

    [_delegate getvalue:nil];
    
    i ++ ;
    [param.callback sendBack: [NSString stringWithFormat:@"%d",i] ];

    
}

- (void)startUpdate:(JamParams*)param
{
    if (timer) return;
    
    
    callbackUpdates = param.callback;
        
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)stopUpdate
{
    updates = 0;
    [timer invalidate];
    timer = nil;
    
    
    [callbackUpdates sendBack:@"reseted"];
    
    callbackUpdates = nil;
}

- (void)tick
{
    updates += 1;
    [callbackUpdates sendBack:[NSString stringWithFormat:@"%d",updates] clean:NO];
}


@end
