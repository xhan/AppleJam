//
//  MainViewBridge.h
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JamModule.h"

@protocol MainViewBridgeDelegate <NSObject>

@required
- (void)messagesend:(id)value;
- (void)getvalue:(id)value;
- (void)startUpdate:(id)value;
- (void)stopUpdate;
@end


@interface MainViewBridge : JamModule
@property(weak) id<MainViewBridgeDelegate> delegate;

@end
