//
//  AppleJam.m
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import "AppleJam.h"
#import "JamCommand.h"
#import "JamCallback.h"
#import "JSONKit.h"
#import <WebKit/WebKit.h>

#define AppleJamScheme @"ajam"

@interface AppleJam()
- (void)insertJavascriptFile:(NSString*)path;
@end

@implementation AppleJam

#pragma mark -
- (id)initWithWebView:(WebView*)view path:(NSURL*)path
{
    self = [self initWithWebView:view
                            path:path
                    customScheme:AppleJamScheme];
    return self;
}
- (id)initWithWebView:(WebView*)view path:(NSURL*)path customScheme:(NSString*)scheme
{
    self = [super init];
    if (self) {
        _scheme = [scheme copy];
        _webView = view;
        II_RETAIN(_webView);
        
        _commands = [[NSMutableDictionary alloc] init];
        
        [_webView setPolicyDelegate:self];  //handle navigation
        [_webView setFrameLoadDelegate:self];//hanlde load state
//        [_webView setEditingDelegate:self]; //disable text selection
//        better way to handle it by add css body {-webkit-user-select: none;}
        
        [_webView setUIDelegate:self];
        [_webView setDrawsBackground:NO];   //remove background
        
        //disable scroll (but also can be disabled in css
        [[[_webView mainFrame] frameView] setAllowsScrolling:NO];
        [[_webView mainFrame] loadRequest:[NSURLRequest requestWithURL:path]];
    }
    return self;
}

#if !II_ARC_ENABLED
- (void)dealloc
{
    [_scheme release];
    [_webView release];
    [_commands release];
    [super dealloc];
}
#endif

#pragma mark -

- (void)setLoadedCallback:(id)target sel:(SEL)sel
{
    callback = target;
    selector = sel;
}

- (NSString*)runScript:(NSString*)script
{
    return [_webView stringByEvaluatingJavaScriptFromString:script];
}


- (BOOL)runCommandFromURL:(NSURL*)url
{
    /*
     ajam://MainViewBridge.getvalue?100#1
     host -> MainViewBridge.getvalue
     query -> params
     fragment -> callback
     */
    
    NSString* scheme = [url scheme];
    NSString* action = [url host];
    id params = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* callbackID=[url fragment];
    if (![scheme isEqualToString:_scheme]) return NO;
    
    NSString *klass =nil ,*method =nil ,*methodParams = nil;
    
    //get class and method
    NSArray* aryClassAndMethod = [action componentsSeparatedByString:@"."];
    if (aryClassAndMethod.count == 2){
        klass = aryClassAndMethod[0];
        method= aryClassAndMethod[1];
        methodParams = [method stringByAppendingString:@":"];
    }
    
    if (!(klass && method)) return NO;
    
    params = [params objectFromJSONString];
    if ([params isKindOfClass:NSArray.class] && [params count] == 1) {
        params = [(NSArray*)params lastObject];
    }else{
        params = nil;
    }
    
    JamParams* jamparams = nil;
    if (params || callbackID) {
        jamparams = [JamParams params:params callback:callbackID jam:self];
    }
    
    //TODO: add delegate
    JamCommand* command = _commands[klass];
    if (!command) {
            command = [[NSClassFromString(klass) alloc] initWithJam:self];
        if (command) {
            _commands[klass] = command;
            II_RELEASE(command);
        }
    }
    
    
    SEL _selectorParams  = NSSelectorFromString(methodParams);
    SEL _selectorNoParam = NSSelectorFromString(method);
    SEL _selector = [command respondsToSelector:_selectorParams] ? _selectorParams : \
        ([command respondsToSelector:_selectorNoParam] ? _selectorNoParam : NULL );
    
    
    if ( _selector ) {
        // add -Wno-arc-performSelector-leaks to Other Warning Flags (WARNING_CFLAGS) to ignore warning
        [command performSelector:_selector
                      withObject:jamparams];
        
        return YES;
    }
    return NO;
}


#pragma mark - WebView Delegates

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation
        request:(NSURLRequest *)request
          frame:(WebFrame *)frame
decisionListener:(id<WebPolicyDecisionListener>)listener
{

    NSURL* url = actionInformation[WebActionOriginalURLKey];
    if ([url isFileURL]) {
        [listener use];
    }else{
        BOOL result = [self runCommandFromURL:url];
        NSLog(@"run command result %d",result);
        if (result) {
            [listener ignore];
        }else{
            [listener use]; //比如load web image等. 这里需要保护下(add option)
        }
        
    }
    
}


- (void)webView:(WebView *)awebView didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame
{
    
//    NSString* jquery = [[NSBundle mainBundle] pathForResource:@"jquery.js" ofType:nil];
    NSString* jam = [[NSBundle mainBundle] pathForResource:@"AppleJamBase.js" ofType:nil];
//    [self insertJavascriptFile:jquery];
    [self insertJavascriptFile:jam];
}


- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    [callback performSelector:selector
                   withObject:self];
}

- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element 
    defaultMenuItems:(NSArray *)defaultMenuItems
{
    // disable right-click context menu
    return nil;
}

/*
- (BOOL)webView:(WebView *)webView shouldChangeSelectedDOMRange:(DOMRange *)currentRange 
     toDOMRange:(DOMRange *)proposedRange 
       affinity:(NSSelectionAffinity)selectionAffinity 
 stillSelecting:(BOOL)flag
{
    // disable text selection -> return NO , but this will disable editing
    return YES;
}
 */

#pragma mark -

- (void)addCommandInstance:(JamCommand*)command
{
    if (command) {
        command.jam = self;
        _commands[NSStringFromClass(command.class)] = command; 
    }
}

- (void)insertJavascriptFile:(NSString*)path
{
    NSString* str = [NSString stringWithFormat:@"document.write(\"<script src='%@' type='text/javascript'></script>\")",path];
    //    NSLog(@"%@",str);
    [self runScript:str];
}
@end
