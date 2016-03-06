// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "CAJsonHandler.h"

@interface CAJsonBooleanHandler : CAJsonHandler


+(CAJsonBooleanHandler*)getInstance;

+(bool)readBoolean:(CAJsonInput*)reader;
+(void)writeBoolean:(bool)value writer:(id<CAJsonOutput>)writer;

@end
