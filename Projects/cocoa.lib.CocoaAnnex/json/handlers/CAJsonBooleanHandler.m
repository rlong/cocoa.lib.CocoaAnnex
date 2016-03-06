// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonBooleanHandler.h"
#import "CAJsonInput.h"

@implementation CAJsonBooleanHandler


static CAJsonBooleanHandler* _instance = nil; 

+(void)initialize {
	
	_instance = [[CAJsonBooleanHandler alloc] init];
	
}

+(CAJsonBooleanHandler*)getInstance { 
	
	return _instance;	
}



+(bool)readBoolean:(CAJsonInput*)reader {
    
    UInt8 currentByte = [reader currentByte];

    if( 't' == currentByte || 'T' == currentByte) {
        
        
        //'t' is the current character
        [reader nextByte]; // 'r' is the current character
        [reader nextByte]; // 'u' is the current character
        [reader nextByte]; // 'e' is the current character
        [reader nextByte]; // after true
        
        return true;
        
        
    } else {
        
        //'f' is the current character
        [reader nextByte]; // 'a' is the current character
        [reader nextByte]; // 'l' is the current character
        [reader nextByte]; // 's' is the current character
        [reader nextByte]; // 'e' is the current character
        [reader nextByte]; // after false
        
        return false;
        
    }

    
}

-(id)readValue:(CAJsonInput*)reader {

    bool value = [CAJsonBooleanHandler readBoolean:reader];
    return [NSNumber numberWithBool:value];
    
    
}


+(void)writeBoolean:(bool)value writer:(id<CAJsonOutput>)writer {
    
    if( value ) {
        
        [writer appendString:@"true"];
        
    } else {
        
        [writer appendString:@"false"];
    }
    
    
}

-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {
    
    NSNumber* booleanNumber = value;
    
    [CAJsonBooleanHandler writeBoolean:[booleanNumber boolValue] writer:writer];
	
}


@end
