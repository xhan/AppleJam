//
//  AppDelegate.m
//  AppleJamDemo
//
//  Created by xhan on 8/9/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppleJam.h"
#import "MainViewBridge.h"

@interface AppDelegate()<MainViewBridgeDelegate,AppleJamDelegate>
@end

@implementation AppDelegate
{
    AppleJam* jam;
}
@synthesize webview;
@synthesize webview;
@synthesize labelInfo;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL*mainviewURL = [[NSBundle mainBundle] URLForResource:@"MainView" withExtension:@"html"];
    
    
    jam = [[AppleJam alloc] initWithWebView:self.webview
                                       path:mainviewURL];
    jam.delegate = self;

}

- (IBAction)onValueChanged:(id)sender {
}


#pragma mark - main view delegate

- (void)messagesend:(NSString*)params
{
    [self.labelInfo setStringValue:params];
}
- (void)getvalue:(id)value
{
    
}
- (void)startUpdate:(id)value
{
    
}
- (void)stopUpdate
{
    
}

#pragma mark - Jam Delegate
- (void)jam:(AppleJam *)jam moduleLoaded:(JamModule *)module
{
    NSLog(@"jam module %@ loaded",module);
    if ([module isKindOfClass:MainViewBridge.class]) {
        ((MainViewBridge*)module).delegate = self;
    }
}

- (void)jam:(AppleJam *)jam loaded:(id)null
{
    NSLog(@"jam loaded");
}


@end
