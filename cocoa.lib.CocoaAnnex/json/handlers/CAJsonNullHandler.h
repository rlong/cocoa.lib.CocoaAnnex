// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonHandler.h"


@interface CAJsonNullHandler : CAJsonHandler {

}

+(CAJsonNullHandler*)getInstance; 

+(id)readNull:(CAJsonInput*)reader;
+(void)writeNullTo:(id<CAJsonOutput>)writer;

@end
