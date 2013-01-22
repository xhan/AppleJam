//
//  AppDelegate.m
//  BordlessWindowDemo
//
//  Created by xhan on 8/11/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "AppDelegate.h"
#import "Bridge.h"




@implementation NSWebView

- (BOOL)mouseDownCanMoveWindow
{
    return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    if ([theEvent type] == NSLeftMouseDragged)
        return NO;
    return YES;
}
@end




@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self.window setMovableByWindowBackground:YES];
    [self.window setAcceptsMouseMovedEvents:YES];
    
    
    [self.webview setDrawsBackground:NO];
    [[self.webview mainFrame] loadRequest:[NSURLRequest requestWithURL:  [[NSBundle mainBundle] URLForResource:@"BordlessView" withExtension:@"html"]]];
    
    
    Bridge*bridge = [[Bridge alloc] init];
    bridge.title = @"!! name !!";
    [[self.webview windowScriptObject] setValue:bridge forKey:@"bridge"];
}

@end



/*
 
 @interface PWin : NSWindow
 
 @end
 
 @implementation PWin
 
 - (BOOL)canBecomeKeyWindow
 {
 return YES;
 }
 
 - (BOOL)canBecomeMainWindow
 {
 return YES;
 }
 
 - (void)sendEvent:(NSEvent *)theEvent
 {
 if ([theEvent type] == NSLeftMouseDown)
 {
 [self mouseDown:theEvent];
 }
 else if ([theEvent type] == NSLeftMouseDragged)
 {
 [self mouseDragged:theEvent];
 }
 else
 {
 [super sendEvent:theEvent];
 }
 }
 
 @end
 
 @interface NSWebView : WebView
 
 @end
*/