// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


@class CAJsonInput;
#import "CAJsonOutput.h"

@interface CAJsonHandler : NSObject {

}




+(CAJsonHandler*)getHandlerForObject:(id)object;
+(CAJsonHandler*)getHandlerForTokenBeginning:(char)tokenBeginning;
-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer;
-(id)readValue:(CAJsonInput*)reader;


@end
