// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CAJsonInput.h"
#import "CAJsonNumberHandler.h"
#import "CAStringHelper.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonNumberHandler () 


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



@implementation CAJsonNumberHandler



static CAJsonNumberHandler* _instance = nil; 

+(void)initialize {
	
	_instance = [[CAJsonNumberHandler alloc] init];
	
}

+(CAJsonNumberHandler*)getInstance { 
	
	return _instance;
	
}

+(NSNumber*)readNumber:(CAJsonInput*)reader {
    
    NSMutableData* data = [reader reserveMutableData];
    
	@try {
        
		UInt8 c = [reader currentByte];
		
		NSNumber* answer;
		
		do {
			
			if( '.' == c || 'e' == c || 'E' == c ) {
                [data appendBytes:&c length:1];
				c = [reader nextByte];
				continue;
			}
			
			if( '+' == c || '-' == c ) {
                [data appendBytes:&c length:1];
				c = [reader nextByte];
				continue;
			}
			
			if( '0' <= c && c <= '9' ) {
                [data appendBytes:&c length:1];
				c = [reader nextByte];
				continue;
			}
			
            
			NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            NSString* numberString = [CAStringHelper getUtf8String:data];
			answer = [numberFormatter numberFromString:numberString];
			return answer;
			
		}while( true );
	}
	@finally {
		[reader releaseMutableData:data];
	}
    
	// code 'should' never arrive here
	BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unexpected code path"];
	@throw e;
    
}


-(id)readValue:(CAJsonInput*)reader {
	
    return [CAJsonNumberHandler readNumber:reader];
	
}



+(void)writeNumber:(NSNumber*)value writer:(id<CAJsonOutput>)writer {

    [writer appendString:[value stringValue]];

}

-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {
	
	
	NSNumber* numberValue = (NSNumber*)value;
    
	[CAJsonNumberHandler writeNumber:numberValue writer:writer];
}

@end
