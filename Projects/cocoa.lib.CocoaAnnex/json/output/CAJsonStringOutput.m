// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAJsonStringOutput.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonStringOutput () 

//NSMutableString* _stringBuffer;
@property (nonatomic, retain) NSMutableString* stringBuffer;
//@synthesize stringBuffer = _stringBuffer;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -



@implementation CAJsonStringOutput



-(void)reset {
	[_stringBuffer setString:@""];
}

-(void)appendChar:(unichar)c {
	[_stringBuffer appendFormat:@"%C", c];
}

-(void)appendString:(NSString*)string { 
	[_stringBuffer appendString:string]; 
}

-(NSString*)toString {
	
	return [NSString stringWithString:_stringBuffer];
}


#pragma mark instance lifecycle

-(id)init {
	
	CAJsonStringOutput* answer = [super init];
	
	
	answer->_stringBuffer = [[NSMutableString alloc] init];
	
	
	return answer;
}

-(void)dealloc {
	
	
	[self setStringBuffer:nil];
	 

}
	 
#pragma mark fields

//NSMutableString* _stringBuffer;
//@property (nonatomic, retain) NSMutableString* stringBuffer;
@synthesize stringBuffer = _stringBuffer;

@end
