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

@interface AppDelegate()<MainViewBridgeDelegate>
@end

@implementation AppDelegate
{
    AppleJam* jam;
}
@synthesize webview;
@synthesize labelInfo;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL*mainviewURL = [[NSBundle mainBundle] URLForResource:@"MainView" withExtension:@"html"];
    
    
    jam = [[AppleJam alloc] initWithWebView:self.webview
                                       path:mainviewURL];
    
    //TODO: move this step to jam delegate
    MainViewBridge*command = [[MainViewBridge alloc] init];
    command.delegate = self;
    
    [jam addCommandInstance: command];
}

- (IBAction)onValueChanged:(id)sender {
}


#pragma mark - main view delegate

- (void)messagesend
{
    [[NSAlert alertWithMessageText:@"hey i got you"
                    defaultButton:@"yeah" alternateButton:@"cat!" otherButton:nil informativeTextWithFormat:@"cocoa:hi javascript. how are you doing?"] runModal];
}
- (void)getvalue:(id)value
{
    
}
- (void)startUpdate
{
    
}
- (void)stopUpdate
{
    
}

@end
