//
//  MainViewBridge.h
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JamCommand.h"

@protocol MainViewBridgeDelegate <NSObject>

@required
- (void)messagesend;
- (void)getvalue:(id)value;
- (void)startUpdate;
- (void)stopUpdate;
@end


@interface MainViewBridge : JamCommand
@property(weak) id<MainViewBridgeDelegate> delegate;

@end