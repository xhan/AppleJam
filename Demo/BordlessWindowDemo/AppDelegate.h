//
//  AppDelegate.h
//  BordlessWindowDemo
//
//  Created by xhan on 8/11/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *webview;

@end
