// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonDataInput.h"
#import "CAJsonObjectHandler.h"
#import "CAJsonObject.h"
#import "CAJsonStringHandler.h"

#import "CALog.h"

@implementation CAJsonObjectHandler


static CAJsonObjectHandler* _instance = nil; 

+(void)initialize {
	
	_instance = [[CAJsonObjectHandler alloc] init];
	
}

+(CAJsonObjectHandler*)getInstance { 
	
	return _instance;
	
}



-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {
	
	CAJsonObject* jsonObject = (CAJsonObject*)value;

	[writer appendChar:'{'];

	NSArray* allKeys = [jsonObject allKeys];
	
	for( long i = 0, count = [allKeys count]; i < count; i++ ) {
		NSString* key = [allKeys objectAtIndex:i];
		
		[[CAJsonStringHandler getInstance] writeValue:key writer:writer];
		
		[writer appendChar:':'];
		
		id embeddedValue = [jsonObject objectForKey:key defaultValue:nil];
		
		CAJsonHandler* valueHander = [CAJsonHandler getHandlerForObject:embeddedValue];
		
		[valueHander writeValue:embeddedValue writer:writer];
		
		if( i+1 < count ) {
			
			[writer appendChar:','];
		}
	}
	
	[writer appendChar:'}'];

	
	
}


-(CAJsonObject*)readJSONObject:(CAJsonInput*)reader { 
	
	CAJsonObject* answer = [[CAJsonObject alloc] init];
	
	[reader nextByte]; // move past the '{'
	
	
	UInt8 b = [reader scanToNextToken];
	
	while( '}' != b ) {
		
		NSString* key = (NSString*)[[CAJsonStringHandler getInstance] readValue:reader];
		
		b = [reader scanToNextToken];
		
		CAJsonHandler* valueHandler = [CAJsonHandler getHandlerForTokenBeginning:b];
		
		id value = [valueHandler readValue:reader];
		
		[answer setObject:value forKey:key];
		
		b = [reader scanToNextToken];
		
	}	
	
	// move past the '}' if we can
	if( [reader hasNextByte] ) {
		
		[reader nextByte];
		
	}
	
	return answer;
	
}

-(id)readValue:(CAJsonDataInput*)reader {
	
	return [self readJSONObject:reader];
	
}


@end
