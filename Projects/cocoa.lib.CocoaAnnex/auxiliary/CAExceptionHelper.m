// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAExceptionHelper.h"
#import "CAJsonArray.h"

@implementation CAExceptionHelper



+(NSException*)getRootCause:(NSException*)e {
    
    
    while( [e isKindOfClass:[BaseException class]] ) { 
        
        BaseException* be = (BaseException*)e;
        
        // end of the line ?
        if( nil == [be cause] ) { 
            
            return be;
            
        }
    }
    
    return e;
        
    
}

+(CAJsonArray*)getStackTrace:(NSException*)e {
    
    e = [self getRootCause:e];

    
    NSArray* callStackSymbols = [e callStackSymbols];
    CAJsonArray* answer = [[CAJsonArray alloc] initWithCapacity:[callStackSymbols count]];
    
    for( NSString* callStackSymbol in callStackSymbols ) {
        NSString* trimmedCallStackSymbol = [callStackSymbol stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [answer add:trimmedCallStackSymbol];
    }
    
    return answer;



}

+(NSString*)getAtosCommand:(NSException*)e { 
    
    e = [self getRootCause:e];
    
    NSProcessInfo* processInfo = [NSProcessInfo processInfo];
	NSArray* arguments = [processInfo arguments];
	NSString* executable = [arguments objectAtIndex:0];
	
	NSMutableString* answer = [[NSMutableString alloc] initWithFormat:@"/usr/bin/atos -o \"%@\"", executable];
	
	
	NSArray* stack = [e callStackReturnAddresses];
	for( NSNumber* n in stack ) {
		[answer appendFormat:@"  0x%lx", [n longValue]];
	}
    //	[stack release];
	
    return answer;
    
}

@end
