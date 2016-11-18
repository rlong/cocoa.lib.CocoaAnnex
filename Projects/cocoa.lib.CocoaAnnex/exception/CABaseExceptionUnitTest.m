// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CABaseExceptionUnitTest.h"
#import "CALog.h"

@implementation CABaseExceptionUnitTest


-(void)test1 {
    Log_enteredMethod();
}



-(void)testUserError
{
	
	// not really a unit test ... just exercising the functionality
	
	@try {
		NSString* technicalError = @"technicalError";
		BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		
		@throw e;
		
	}
	@catch (BaseException * e) {
		Log_errorException( e );
        
	}
    
}


+(void)testExceptionOnClass {
	@try {
		NSString* technicalError = @"technicalError";
		BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		
		@throw e;
		
	}
	@catch (BaseException * e) {
		Log_errorException( e );
		
	}
	
}

-(void)testExceptionOnObject {
    
	@try {
		NSString* technicalError = @"technicalError";
		BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		
		@throw e;
		
	}
	@catch (BaseException * e) {
		Log_errorException( e );
		
	}
	
	[CABaseExceptionUnitTest testExceptionOnClass];
	
}

-(void)testFormattedException {
    
    
    @try {
        NSString* stringValue = @"string";
        int intValue = 3;
        float floatValue = 3.14;
        void* pointerValue = nil;
        
        @throw [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"'%@', %d, %f, %p", stringValue, intValue, floatValue, pointerValue];
        
    }
    @catch (CABaseException *exception) {
        
        Log_debugString( [exception reason] );
        XCTAssertTrue( [@"'string', 3, 3.140000, 0x0" isEqualToString:[exception reason]], @"actual = %@", [exception reason]);
        
    }
    
    
}

@end
