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
    NSDictionary*_commands;
}
- (id)initWithWebView:(WebView*)view path:(NSString*)path;
- (id)initWithWebView:(WebView*)view path:(NSString*)path customScheme:(NSString*)scheme;

- (NSString*)runJavascript:(NSString*)script;

- (BOOL)runCommandFromURL:(NSURL*)url;
@end
