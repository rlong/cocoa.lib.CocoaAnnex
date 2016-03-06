// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonInput.h"
#import "CAJsonNullHandler.h"

@implementation CAJsonNullHandler


static CAJsonNullHandler* _instance = nil; 

+(void)initialize {
	
	_instance = [[CAJsonNullHandler alloc] init];
	
}

+(CAJsonNullHandler*)getInstance { 
	
	return _instance;
	
}


+(id)readNull:(CAJsonInput*)reader {
    
    //'n' is the current character
	
	[reader nextByte]; // 'u' is the current character
	[reader nextByte]; // 'l' is the current character
	[reader nextByte]; // 'l' is the current character
	[reader nextByte]; // after null
	
	return nil;

}


-(id)readValue:(CAJsonInput*)reader {
    
    return [CAJsonNullHandler readNull:reader];
	
}


+(void)writeNullTo:(id<CAJsonOutput>)writer {
    
    [writer appendString:@"null"];

}


-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {
	
    [CAJsonNullHandler writeNullTo:writer];
	
}



@end
