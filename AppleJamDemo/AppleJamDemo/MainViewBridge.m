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
- (void)messagesend
{
    [_delegate messagesend];
}
- (void)getvalue:(id)value
{
    static int i = 0;

    [_delegate getvalue:value];
    if (self.callbackID) {
        JamCallback*callback = [[JamCallback alloc] init];
        callback.jam = self.jam;
        callback.uid = self.callbackID;
        i ++ ;
        id value = [NSString stringWithFormat:@"%d",i];
        dispatch_async(dispatch_get_main_queue(), ^{
            [callback sendBack:value];
            self.callbackID = nil;
        });
//        [callback performSelector:@selector(sendBack:)
//                       withObject:value
//                       afterDelay:0.1];
    }
}

- (void)startUpdate
{
    if (timer) return;
    
    
    if (self.callbackID) {
        callbackUpdates = [[JamCallback alloc] init];
        callbackUpdates.jam = self.jam;
        callbackUpdates.uid = self.callbackID;
    }
        
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
