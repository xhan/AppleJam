//
//  AppleJam.h
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebView;
@interface AppleJam : NSObject
{
    NSString *scheme;
    WebView  *webView;
    NSDictionary*commands;
}
- (id)initWithWebView:(WebView*)view path:(NSString*)path;
- (id)initWithWebView:(WebView*)view path:(NSString*)path customScheme:(NSString*)scheme;

- (void)runJavascript:(NSString*)script;
@end
