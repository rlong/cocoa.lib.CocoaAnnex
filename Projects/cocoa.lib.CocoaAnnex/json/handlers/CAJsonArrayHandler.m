// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonArray.h"
#import "CAJsonArrayHandler.h"
#import "CAJsonDataInput.h"
#import "CAJsonStringOutput.h"


@implementation CAJsonArrayHandler


static CAJsonArrayHandler* _instance = nil; 

+(void)initialize {
	
	_instance = [[CAJsonArrayHandler alloc] init];
	
}

+(CAJsonArrayHandler*)getInstance { 
	
	return _instance;
	
}



-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {
	
	CAJsonArray* array = (CAJsonArray*)value;
	
	[writer appendChar:'['];
	
	
	long count = [array count];
	
	
	if( count > 0 ) {
		
		id object = [array objectAtIndex:0 defaultValue:nil];
		
		CAJsonHandler* valueHandler = [CAJsonHandler getHandlerForObject:object];
		
		[valueHandler writeValue:object writer:writer];
	
		
	}
	for( int i = 1; i < count; i++ ) {
		[writer appendChar:','];

		id object = [array objectAtIndex:i defaultValue:nil];
		
		CAJsonHandler* valueHandler = [CAJsonHandler getHandlerForObject:object];
		
		[valueHandler writeValue:object writer:writer];
		
	}
	
	
	[writer appendChar:']'];
	
	
}




-(CAJsonArray*)readJSONArray:(CAJsonInput*)reader {
	
	CAJsonArray* answer = [[CAJsonArray alloc] init];
	
	[reader nextByte]; // move past the '['
	
	
	UInt8 b = [ reader scanToNextToken];
	
	while( ']' != b ) {
		
		CAJsonHandler* valueHandler =  [CAJsonHandler getHandlerForTokenBeginning:b];
		
		
		id object = [valueHandler readValue:reader];
		
		[answer add:object];
		
		b = [reader scanToNextToken];
		
	}	
	
	// move past the ']' if we can
	
	if( [reader hasNextByte] ) {
		
		[reader nextByte];
		
	}
	
	
	return answer;
	
	
}

-(id)readValue:(CAJsonDataInput*)reader {
	
	return [self readJSONArray:reader];
	
	
}



@end
