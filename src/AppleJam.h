//
//  AppleJam.h
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: 右键处理
// TODO: global drag, scroll event prevent
// TODO: 属性控制, 是否有窗口等

@class WebView,JamCommand;
@interface AppleJam : NSObject
{
    NSString *_scheme;
    WebView  *_webView;
    NSMutableDictionary*_commands;
    
    id callback;
    SEL selector;
}
- (id)initWithWebView:(WebView*)view path:(NSURL*)path;
- (id)initWithWebView:(WebView*)view path:(NSURL*)path customScheme:(NSString*)scheme;

- (NSString*)runScript:(NSString*)script;

- (BOOL)runCommandFromURL:(NSURL*)url;

// -pageLoaded:(AppleJam*)jam
- (void)setLoadedCallback:(id)target sel:(SEL)sel;

- (void)addCommandInstance:(JamCommand*)command;
@end
