//
//  AppleJam.m
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import "AppleJam.h"
#import "JamCommand.h"
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
        _scheme = [scheme copy];
        _webView = [view retain];
        _commands = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_scheme release];
    [_webView release];
    [_commands release];
    [super dealloc];
}

#pragma mark -

- (NSString*)runJavascript:(NSString*)script
{
    return [_webView stringByEvaluatingJavaScriptFromString:script];
}

// scheme:ClassName.method?params
- (BOOL)runCommandFromURL:(NSURL*)url
{
    NSString* scheme = [url scheme];
    NSString* action = [url resourceSpecifier];
    if (![scheme isEqualToString:_scheme]) return NO;
    
    NSString *klass =nil ,*method =nil, *params = nil, *klassAndMethod;
    
    NSArray* arySplitByParam = [action componentsSeparatedByString:@"?"];    
    if (arySplitByParam.count > 1) {
        // we do have params
        klassAndMethod = [arySplitByParam objectAtIndex:0];
        params = [action stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@?,klassAndMethod"] withString:@""];                
    }else{
        klassAndMethod = action;
    }
    
    NSArray* aryClassAndMethod = [klassAndMethod componentsSeparatedByString:@"."];
    if (aryClassAndMethod.count == 2){
        klass = [aryClassAndMethod objectAtIndex:0];
        method= [aryClassAndMethod objectAtIndex:1];
    }
    
    if (!(klass && method)) return NO;
    
    JamCommand* command = [_commands objectForKey:klass];
    if (!command) {
            command = [[NSClassFromString(klass) alloc] initWithJam:self];
        if (command) {
            [_commands setValue:command forKey:klass];
            [command release];
        }
    }
    
    if ([command respondsToSelector:NSSelectorFromString(method)]) {
        [command performSelector:NSSelectorFromString(method)
                      withObject:params];
        return YES;
    }
    return NO;
}
@end
