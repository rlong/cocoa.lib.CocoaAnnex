// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAJsonDataInput.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonDataInput () 

//NSData* _data;
@property (nonatomic, retain) NSData* data;
//@synthesize data = _data;

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation CAJsonDataInput


-(void)reset {
	_cursor = 0;
	
}

-(BOOL)hasNextByte {
	
	if( 1 + _cursor >= [_data length] ) { 
		return false;
	}
	return true;
						
}

-(UInt8)nextByte {
	_cursor++;
	
	UInt8* bytes = (UInt8*)[_data bytes];	
	return bytes[_cursor];
}

-(UInt8)currentByte {
	
	UInt8* bytes = (UInt8*)[_data bytes];
	return bytes[_cursor];
}




#pragma mark instance lifecycle

-(id)initWithData:(NSData*)data {
	
	CAJsonDataInput* answer = [super init];
	
	
	[answer setData:data];
	answer->_cursor = 0;
	
	
	return answer;
	
}

-(void)dealloc { 
	
	
	[self setData:nil];
	
}

#pragma mark fields


//NSData* _data;
//@property (nonatomic, retain) NSData* data;
@synthesize data = _data;


//int _cursor;
//@property (nonatomic, readonly) int cursor;
@synthesize cursor = _cursor;




@end
