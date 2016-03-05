// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CANumericUtilities.h"
#import "CANumericUtilitiesUnitTest.h"


@implementation CANumericUtilitiesUnitTest


-(void)testParseIntegerGood
{
	
	NSString* integerString = @"12";
	
	int integerValue = [CANumericUtilities parseInteger:integerString];
	
	XCTAssertTrue( 12 == integerValue, @"actual = %d", integerValue );		
}

-(void)testParseIntegerBadData
{
	
	NSString* integerValue = @"blah blah";
	
	@try
	{
		
		[CANumericUtilities parseInteger:integerValue];
		XCTFail( @"element does not have parseable integer data" );
	}
	@catch( BaseException* e )
	{
		// good
	}

}

-(void)testParseIntegerEmptyData
{
	
	NSString* integerValue = @"";
	
	@try
	{
		[CANumericUtilities parseInteger:integerValue];
		XCTAssertTrue( NO, @"element does not have any data" );		
	}
	@catch( BaseException* e )
	{
		// good
	}
}


-(void)testParseDoubleGood
{
	
	NSString* doubleString = @"-3.14";
	
	double doubleValue = [CANumericUtilities parseDouble:doubleString];
	
	XCTAssertTrue( -3.14 == doubleValue, @"actual = %f", doubleValue );		
}

-(void)testParse_15_650912 {
    
	
	NSString* doubleString = @"15.650912";
	
	double doubleValue = [CANumericUtilities parseDouble:doubleString];
	
	XCTAssertTrue( 15.650912 == doubleValue, @"actual = %f", doubleValue );
}



-(void)testParseDoubleBadData
{
	
	NSString* doubleString = @"blah blah";
	
	@try
	{
		
		[CANumericUtilities parseDouble:doubleString];
		XCTFail( @"element does not have parseable integer data" );
	}
	@catch( BaseException* e )
	{
		// good
	}
	
}

-(void)testParseDoubleEmptyData
{
	
	NSString* doubleString = @"";
	
	@try
	{
		[CANumericUtilities parseDouble:doubleString];
		XCTAssertTrue( NO, @"element does not have any data" );		
	}
	@catch( BaseException* e )
	{
		// good
	}
}

@end
