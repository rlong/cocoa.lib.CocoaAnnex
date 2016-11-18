// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CAJsonArray.h"
#import "CAJsonArrayHandler.h"
#import "CAJsonBooleanHandler.h"
#import "CAJsonHandler.h"
#import "CAJsonInput.h"
#import "CAJsonNullHandler.h"
#import "CAJsonNumberHandler.h"
#import "CAJsonObject.h"
#import "CAJsonObjectHandler.h"
#import "CAJsonDataInput.h"
#import "CAJsonStringHandler.h"
#import "CAJsonStringOutput.h"



@implementation CAJsonHandler



+(CAJsonHandler*)getHandlerForObject:(id)object {
	
	if( nil == object ) {
		return [CAJsonNullHandler getInstance];		
	}
	
	
	////////////////////////////////////////////////////////////////////////
	
	
	if( [object isKindOfClass:[CAJsonArray class]] ) { 
		return [CAJsonArrayHandler getInstance];
	}
	
	if( [object isKindOfClass:[NSNumber class]] ) { 
        
        NSNumber* number = (NSNumber*)object;
        
        const char* objCType = [number objCType];
        
        /// vvv http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
        
        if (strcmp(objCType, @encode(BOOL)) == 0) {
            
        /// ^^^ http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
            
            return [CAJsonBooleanHandler getInstance];
        }
        
		return [CAJsonNumberHandler getInstance];
	}
	
	if( [object isKindOfClass:[CAJsonObject class]] ) { 
		return [CAJsonObjectHandler getInstance];
	}
	
	if( [object isKindOfClass:[NSString class]] ) { 
		return [CAJsonStringHandler getInstance];
	}
	
	////////////////////////////////////////////////////////////////////////
    
    Class clazz = [object class];
    
    NSString* technicalError = [NSString stringWithFormat:@"unsupported type; NSStringFromClass(clazz) = %@", NSStringFromClass(clazz)];
    
    BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
    @throw  e;
    
	
	
}

+(CAJsonHandler*)getHandlerForTokenBeginning:(char)tokenBeginning { 
	
	if( '"' == tokenBeginning ) {
		return [CAJsonStringHandler getInstance];
	}	
	
	if( '0' <= tokenBeginning && tokenBeginning <= '9' ) {
		return [CAJsonNumberHandler getInstance];
	}
	
	if( '[' == tokenBeginning ) {
		return [CAJsonArrayHandler getInstance];
	}
	
	if( '{' == tokenBeginning ) { 
		return [CAJsonObjectHandler getInstance];
	}
	
	if( '+' == tokenBeginning ) {
		return [CAJsonNumberHandler getInstance];
	}
	if( '-' == tokenBeginning ) {
		return [CAJsonNumberHandler getInstance];
	}
	
	
	if( 't' == tokenBeginning || 'T' == tokenBeginning) {
        return [CAJsonBooleanHandler getInstance];
	}
	
	if( 'f' == tokenBeginning || 'F' == tokenBeginning) {
        return [CAJsonBooleanHandler getInstance];
	}
	
	if( 'n' == tokenBeginning || 'N' == tokenBeginning) {
		return [CAJsonNullHandler getInstance];
	}
	
	
	NSString* technicalError = [NSString stringWithFormat:@"bad tokenBeginning; tokenBeginning = %d (%c)", tokenBeginning, tokenBeginning];
	
	BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
	@throw e;
	
}


-(void)writeValue:(id)value writer:(id<CAJsonOutput>)writer {

	BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unimplemented"];
	@throw e;
	
}

-(id)readValue:(CAJsonInput*)reader { 
	BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unimplemented"];
	@throw e;
}


#pragma mark instance lifecycle

-(id)init { 
	
	CAJsonHandler* answer = [super init];
	
	
	return answer;
	
}

-(void)dealloc { 

}


@end
