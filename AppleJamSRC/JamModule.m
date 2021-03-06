//
//  JamCommand.m
//  LessDJ
//
//  Created by xu xhan on 2/17/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import "JamModule.h"
#import "AppleJam.h"

@implementation JamModule
@synthesize jam = _jam;
- (id)initWithJam:(AppleJam*)ajam
{
    self = [super init];
    _jam = ajam;
    return self;
}

- (NSString*)runScript:(NSString*)script
{
    return [_jam runScript:script];
}

@end
