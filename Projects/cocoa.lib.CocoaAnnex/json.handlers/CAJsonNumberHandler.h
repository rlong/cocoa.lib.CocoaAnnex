// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonHandler.h"


@interface CAJsonNumberHandler : CAJsonHandler {

	
}

+(CAJsonNumberHandler*)getInstance;

+(NSNumber*)readNumber:(CAJsonInput*)reader;
+(void)writeNumber:(NSNumber*)value writer:(id<CAJsonOutput>)writer;


@end
