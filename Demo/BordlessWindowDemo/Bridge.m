//
//  Bridge.m
//  AppleJamDemo
//
//  Created by xhan on 8/14/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "Bridge.h"

@implementation Bridge
- (NSString*)name
{
    return @"bridge's name :D";
}


+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{
    return NO;
}
+ (BOOL)isKeyExcludedFromWebScript:(const char *)name
{
    return NO;
}

@end
