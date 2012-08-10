//
//  AppleJam.h
//  LessDJ
//
//  Created by xu xhan on 2/16/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppleJamHeader.h"
// TODO: 右键处理
// TODO: global drag, scroll event prevent
// TODO: 属性控制, 是否有窗口等

@class WebView,JamModule,AppleJam;
@protocol AppleJamDelegate ;


@interface AppleJam : NSObject
{
    NSString *_scheme;
    WebView  *_webView;
    NSMutableDictionary*_modules;
    
}
@property(weak) id<AppleJamDelegate> delegate;

- (id)initWithWebView:(WebView*)view path:(NSURL*)path;
- (id)initWithWebView:(WebView*)view path:(NSURL*)path customScheme:(NSString*)scheme;

- (NSString*)runScript:(NSString*)script;

- (JamModule*)attachModuleClass:(Class)klass;
- (void)attachModule:(JamModule*)command;

@end




@protocol AppleJamDelegate <NSObject>

@optional
- (void)jam:(AppleJam*)jam loaded:(id)null;
- (void)jam:(AppleJam*)jam moduleLoaded:(JamModule*)module;

@end