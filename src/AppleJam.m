//
//  AppleJam.m
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import "AppleJam.h"
#import <WebKit/WebKit.h>

#define AppleJamScheme @"ajam"

@implementation AppleJam

#pragma mark -
- (id)initWithWebView:(WebView*)view path:(NSString*)path
{
    self = [self initWithWebView:view
                            path:path
                    customScheme:AppleJamScheme];
    return self;
}
- (id)initWithWebView:(WebView*)view path:(NSString*)path customScheme:(NSString*)scheme
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -

- (void)runJavascript:(NSString*)script
{
    [webView stringByEvaluatingJavaScriptFromString:script];
}
@end
