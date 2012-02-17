//
//  JamCommand.h
//  LessDJ
//
//  Created by xu xhan on 2/17/12.
//  Copyright (c) 2012 xu han. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppleJam;
@interface JamCommand : NSObject
{
    AppleJam* _jam; //assign
}
- (id)initWithJam:(AppleJam*)jam;
@property(assign,nonatomic) AppleJam* jam;

- (NSString*)runScript:(NSString*)script;
@end
